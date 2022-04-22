#!/usr/bin/env python3
#
# Mutt OAuth2 token management script, version 2020-08-07
# Written against python 3.7.3, not tried with earlier python versions.
#
# Portions modified by fjacobs@vmware.com 2020-10-12
# Portions modified by jeffda@vmware.com 2022-04-19
#
#   Copyright (C) 2020 Alexander Perlis
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#   02110-1301, USA.
'''Mutt OAuth2 token management'''

import sys
import json
import yaml
import argparse
import urllib.parse
import urllib.request
import imaplib
import poplib
import smtplib
import base64
import secrets
import hashlib
import time
from datetime import timedelta, datetime
from pathlib import Path
import socket
import http.server
import subprocess
import textwrap

### fjacobs: Customize the following three configuration parameters:

# My tenant and client IDs from the app I created in azure:
o365_tenant_id = 'b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0'
o365_client_id = 'c4bb29ed-69d7-475f-b8e8-08f1bc024d08'

### fjacobs: It should not be necessary to edit anything below this line.


registrations = {
    'google': {
        'authorize_endpoint': 'https://accounts.google.com/o/oauth2/auth',
        'devicecode_endpoint': 'https://oauth2.googleapis.com/device/code',
        'token_endpoint': 'https://accounts.google.com/o/oauth2/token',
        'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
        'imap_endpoint': 'imap.gmail.com',
        'pop_endpoint': 'pop.gmail.com',
        'smtp_endpoint': 'smtp.gmail.com',
        'sasl_method': 'OAUTHBEARER',
        'scope': 'https://mail.google.com/',
        'client_id': '',
        'client_secret': '',
    },
    'microsoft': {
        'authorize_endpoint': 'https://login.microsoftonline.com/' + o365_tenant_id + '/oauth2/v2.0/authorize',
        'devicecode_endpoint': 'https://login.microsoftonline.com/' + o365_tenant_id + '/oauth2/v2.0/devicecode',
        'token_endpoint': 'https://login.microsoftonline.com/' + o365_tenant_id + '/oauth2/v2.0/token',
        'redirect_uri': 'https://login.microsoftonline.com/common/oauth2/nativeclient',
        'tenant': o365_tenant_id,
        'imap_endpoint': 'outlook.office365.com',
        'pop_endpoint': 'outlook.office365.com',
        'smtp_endpoint': 'smtp.office365.com',
        'sasl_method': 'XOAUTH2',
        'scope': ('offline_access https://outlook.office.com/IMAP.AccessAsUser.All '
                  'https://outlook.office.com/POP.AccessAsUser.All '
                  'https://outlook.office.com/SMTP.Send'),
        'client_id': o365_client_id,
        'client_secret': '',
    },
}

def writesecret():
    '''Writes global token dictionary into token file.'''
    sub2 = subprocess.run(ENCRYPTION_PIPE, check=True, input=yaml.dump(token).encode(),
                          stdout=subprocess.PIPE, stderr=subprocess.PIPE)


def build_sasl_string(user, host, port, bearer_token):
    '''Build appropriate SASL string, which depends on cloud server's supported SASL method.'''
    if registration['sasl_method'] == 'OAUTHBEARER':
        return f'n,a={user},\1host={host}\1port={port}\1auth=Bearer {bearer_token}\1\1'
    if registration['sasl_method'] == 'XOAUTH2':
        return f'user={user}\1auth=Bearer {bearer_token}\1\1'
    sys.exit(f'Unknown SASL method {registration["sasl_method"]}.')

def access_token_valid():
    '''Returns True when stored access token exists and is still valid at this time.'''
    token_exp = token['access_token_expiration']
    expires = datetime.strptime(token_exp, "%Y-%m-%dT%H:%M:%S.%f")
    return token_exp and datetime.now() < expires #datetime.fromisoformat(token_exp)


def update_tokens(r):
    '''Takes a response dictionary, extracts tokens out of it, and updates token file.'''
    token['access_token'] = r['access_token']
    token['access_token_expiration'] = (datetime.now() +
                                        timedelta(seconds=int(r['expires_in']))).isoformat()
    if 'refresh_token' in r:
        token['refresh_token'] = r['refresh_token']
    writesecret()
    if args.verbose:
        print(f'NOTICE: Obtained new access token, expires {token["access_token_expiration"]}.')


ap = argparse.ArgumentParser(epilog='''
This script obtains and prints a valid OAuth2 access token.  State is maintained in an
encrypted secret.  Run with "--verbose --authorize" to get started or whenever all
tokens have expired, optionally with "--authflow" to override the default authorization
flow.  To truly start over from scratch, first delete secret.  Use "--verbose --test"
to test the IMAP/POP/SMTP endpoints.
''')
ap.add_argument('-v', '--verbose', action='store_true', help='increase verbosity')
ap.add_argument('-d', '--debug', action='store_true', help='enable debug output')
ap.add_argument('secret', help='path to gopass secret to store oauth token')
ap.add_argument('-a', '--authorize', action='store_true', help='manually authorize new tokens')
ap.add_argument('--authflow', help='authcode | localhostauthcode | devicecode')
ap.add_argument('-t', '--test', action='store_true', help='test IMAP/POP/SMTP endpoints')
args = ap.parse_args()

token = {}

# The token file must be encrypted because it contains multi-use bearer tokens
# whose usage does not require additional verification. Specify whichever
# encryption and decryption pipes you prefer. They should read from standard
# input and write to standard output. The example values here invoke GPG,
# although won't work until an appropriate identity appears in the first line.
ENCRYPTION_PIPE = ['gopass', 'insert', '-f', args.secret]
DECRYPTION_PIPE = ['gopass', 'show', args.secret]
DETECTION_PIPE  = ['gopass', 'search', args.secret]

detect = subprocess.run(DETECTION_PIPE, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
if detect.returncode == 0:
    if detect.stdout.count('\n') != 1:
        print("results found:")
        print(textwrap.dedent(detect.stdout))
        sys.exit('Too many results found for ' + args.secret + " please narrow down search")
    try:
        decrypt = subprocess.run(DECRYPTION_PIPE, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        token = yaml.safe_load(decrypt.stdout)
    except subprocess.CalledProcessError:
        print('Difficulty decrypting token file. Is your decryption agent primed for '
                 'non-interactive usage, or an appropriate environment variable such as '
                 'GPG_TTY set to allow interactive agent usage from inside a pipe?')
else:
    print(detect.stderr)

        

if args.debug:
    print('Obtained from token file:', yaml.dump(token))
if not token:
    if not args.authorize:
        sys.exit('You must run script with "--authorize" at least once.')
    print('Available app and endpoint registrations:', *registrations)
    token['registration'] = input('OAuth2 registration: ')
    token['authflow'] = input('Preferred OAuth2 flow ("authcode" or "localhostauthcode" '
                              'or "devicecode"): ')
    token['email'] = input('Account e-mail address: ')
    token['access_token'] = ''
    token['access_token_expiration'] = ''
    token['refresh_token'] = ''
    writesecret()

if token['registration'] not in registrations:
    sys.exit(f'ERROR: Unknown registration "{token["registration"]}". Delete token file '
             f'and start over.')
registration = registrations[token['registration']]

authflow = token['authflow']
if args.authflow:
    authflow = args.authflow

baseparams = {'client_id': registration['client_id']}
# Microsoft uses 'tenant' but Google does not
if 'tenant' in registration:
    baseparams['tenant'] = registration['tenant']



if args.authorize:
    p = baseparams.copy()
    p['scope'] = registration['scope']

    if authflow in ('authcode', 'localhostauthcode'):
        verifier = secrets.token_urlsafe(90)
        challenge = base64.urlsafe_b64encode(hashlib.sha256(verifier.encode()).digest())[:-1]
        redirect_uri = registration['redirect_uri']
        listen_port = 0
        if authflow == 'localhostauthcode':
            # Find an available port to listen on
            s = socket.socket()
            s.bind(('127.0.0.1', 0))
            listen_port = s.getsockname()[1]
            s.close()
            redirect_uri = 'http://localhost:'+str(listen_port)+'/'
            # Probably should edit the port number into the actual redirect URL.

        p.update({'login_hint': token['email'],
                  'response_type': 'code',
                  'redirect_uri': redirect_uri,
                  'code_challenge': challenge,
                  'code_challenge_method': 'S256'})
        print(registration["authorize_endpoint"] + '?' +
              urllib.parse.urlencode(p, quote_via=urllib.parse.quote))

        authcode = ''
        if authflow == 'authcode':
            authcode = input('Visit displayed URL to retrieve authorization code. Enter '
                             'code from server (might be in browser address bar): ')
        else:
            print('Visit displayed URL to authorize this application. Waiting...',
                  end='', flush=True)

            class MyHandler(http.server.BaseHTTPRequestHandler):
                '''Handles the browser query resulting from redirect to redirect_uri.'''

                # pylint: disable=C0103
                def do_HEAD(self):
                    '''Response to a HEAD requests.'''
                    self.send_response(200)
                    self.send_header('Content-type', 'text/html')
                    self.end_headers()

                def do_GET(self):
                    '''For GET request, extract code parameter from URL.'''
                    # pylint: disable=W0603
                    global authcode
                    querystring = urllib.parse.urlparse(self.path).query
                    querydict = urllib.parse.parse_qs(querystring)
                    if 'code' in querydict:
                        authcode = querydict['code'][0]
                    self.do_HEAD()
                    self.wfile.write(b'<html><head><title>Authorizaton result</title></head>')
                    self.wfile.write(b'<body><p>Authorization redirect completed. You may '
                                     b'close this window.</p></body></html>')
            with http.server.HTTPServer(('127.0.0.1', listen_port), MyHandler) as httpd:
                try:
                    httpd.handle_request()
                except KeyboardInterrupt:
                    pass

        if not authcode:
            sys.exit('Did not obtain an authcode.')

        for k in 'response_type', 'login_hint', 'code_challenge', 'code_challenge_method':
            del p[k]
        p.update({'grant_type': 'authorization_code',
                  'code': authcode,
                  'client_secret': registration['client_secret'],
                  'code_verifier': verifier})
        try:
            response = urllib.request.urlopen(registration['token_endpoint'],
                                              urllib.parse.urlencode(p).encode())
        except urllib.error.HTTPError as err:
            print(err.code, err.reason)
            response = err
        response = response.read()
        if args.debug:
            print(response)
        response = json.loads(response)
        if 'error' in response:
            print(response['error'])
            if 'error_description' in response:
                print(response['error_description'])
            sys.exit(1)

    elif authflow == 'devicecode':
        try:
            response = urllib.request.urlopen(registration['devicecode_endpoint'],
                                              urllib.parse.urlencode(p).encode())
        except urllib.error.HTTPError as err:
            print(err.code, err.reason)
            response = err
        response = response.read()
        if args.debug:
            print(response)
        response = json.loads(response)
        if 'error' in response:
            print(response['error'])
            if 'error_description' in response:
                print(response['error_description'])
            sys.exit(1)
        print(response['message'])
        del p['scope']
        p.update({'grant_type': 'urn:ietf:params:oauth:grant-type:device_code',
                  'client_secret': registration['client_secret'],
                  'device_code': response['device_code']})
        interval = int(response['interval'])
        print('Polling...', end='', flush=True)
        while True:
            time.sleep(interval)
            print('.', end='', flush=True)
            try:
                response = urllib.request.urlopen(registration['token_endpoint'],
                                                  urllib.parse.urlencode(p).encode())
            except urllib.error.HTTPError as err:
                # Not actually always an error, might just mean "keep trying..."
                response = err
            response = response.read()
            if args.debug:
                print(response)
            response = json.loads(response)
            if 'error' not in response:
                break
            if response['error'] == 'authorization_declined':
                print(' user declined authorization.')
                sys.exit(1)
            if response['error'] == 'expired_token':
                print(' too much time has elapsed.')
                sys.exit(1)
            if response['error'] != 'authorization_pending':
                print(response['error'])
                if 'error_description' in response:
                    print(response['error_description'])
                sys.exit(1)
        print()

    else:
        sys.exit(f'ERROR: Unknown OAuth2 flow "{token["authflow"]}. Delete token file and '
                 f'start over.')

    update_tokens(response)


if not access_token_valid():
    if args.verbose:
        print('NOTICE: Invalid or expired access token; using refresh token '
              'to obtain new access token.')
    if not token['refresh_token']:
        sys.exit('ERROR: No refresh token. Run script with "--authorize".')
    p = baseparams.copy()
    p.update({'client_secret': registration['client_secret'],
              'refresh_token': token['refresh_token'],
              'grant_type': 'refresh_token'})
    try:
        response = urllib.request.urlopen(registration['token_endpoint'],
                                          urllib.parse.urlencode(p).encode())
    except urllib.error.HTTPError as err:
        print(err.code, err.reason)
        response = err
    response = response.read()
    if args.debug:
        print(response)
    response = json.loads(response)
    if 'error' in response:
        print(response['error'])
        if 'error_description' in response:
            print(response['error_description'])
        print('Perhaps refresh token invalid. Try running once with "--authorize"')
        sys.exit(1)
    update_tokens(response)


if not access_token_valid():
    sys.exit('ERROR: No valid access token. This should not be able to happen.')


if args.verbose:
    print('Access Token: ', end='')
print(token['access_token'])



if args.test:
    errors = False

    imap_conn = imaplib.IMAP4_SSL(registration['imap_endpoint'])
    sasl_string = build_sasl_string(token['email'], registration['imap_endpoint'], 993,
                                    token['access_token'])
    if args.debug:
        imap_conn.debug = 4
    try:
        imap_conn.authenticate(registration['sasl_method'], lambda _: sasl_string.encode())
        # Microsoft has a bug wherein a mismatch between username and token can still report a
        # successful login... (Try a consumer login with the token from a work/school account.)
        # Fortunately subsequent commands fail with an error. Thus we follow AUTH with another
        # IMAP command before reporting success.
        imap_conn.list()
        if args.verbose:
            print('IMAP authentication succeeded')
    except imaplib.IMAP4.error as e:
        print('IMAP authentication FAILED (does your account allow IMAP?):', e)
        errors = True
#    try:
#        imap_conn.select(mailbox='INBOX', readonly=False)
#        print('Set inbox')
#    except imaplib.IMAP4.error as e:
#        print('IMAP: could not set inbox:', e)
#        errors = True
#    try:
#        typ, early_msg_ids = imap_conn.search(None, 'BEFORE 2-May-2017')
#        typ, late_msg_ids = imap_conn.search(None, 'SINCE 1-Aug-2020')
#        typ, new_msg_ids = imap_conn.search(None, 'RECENT')
#        print("got early_msg_ids: " + str(early_msg_ids))
#        print("got late_msg_ids: " + str(late_msg_ids))
#        print("got new_msg_ids: " + str(new_msg_ids))
#        imap_conn._simple_command('MOVE', '70002:80002', 'to-oct-2020')
#        print('Performed move')
#    except imaplib.IMAP4.error as e:
#        print('IMAP: could not move:', e)
#        errors = True

    pop_conn = poplib.POP3_SSL(registration['pop_endpoint'])
    sasl_string = build_sasl_string(token['email'], registration['pop_endpoint'], 995,
                                    token['access_token'])
    if args.debug:
        pop_conn.set_debuglevel(2)
    try:
        # poplib doesn't have an auth command taking an authenticator object
        # Microsoft requires a two-line SASL for POP
        # pylint: disable=W0212
#        pop_conn._shortcmd('AUTH ' + registration['sasl_method'])
#        pop_conn._shortcmd(base64.standard_b64encode(sasl_string.encode()).decode())
        pop_conn._putcmd('AUTH ' + registration['sasl_method'] + '\r\n' + base64.standard_b64encode(sasl_string.encode()).decode())
        if args.verbose:
            print('POP authentication succeeded')
    except poplib.error_proto as e:
        print('POP authentication FAILED (does your account allow POP?):', e.args[0].decode())
        errors = True

    # SMTP_SSL would be simpler but Microsoft does not answer on port 465.
    smtp_conn = smtplib.SMTP(registration['smtp_endpoint'], 587)
    sasl_string = build_sasl_string(token['email'], registration['smtp_endpoint'], 587,
                                    token['access_token'])
    smtp_conn.ehlo('test')
    smtp_conn.starttls()
    smtp_conn.ehlo('test')
    if args.debug:
        smtp_conn.set_debuglevel(2)
    try:
        smtp_conn.auth(registration['sasl_method'], lambda _=None: sasl_string)
        if args.verbose:
            print('SMTP authentication succeeded')
    except smtplib.SMTPAuthenticationError as e:
        print('SMTP authentication FAILED:', e)
        errors = True

    if errors:
        sys.exit(1)

