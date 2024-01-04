#!/usr/bin/env bash

#### This script will allow you to pass CNAP macOS 13 (Ventura) compliance requirement.
#### Fix steps are pulled from the published DISA STIG or from macOS 13 Security Configuration, NIST SP 800-53 Rev 5 Moderate Impact Security Baseline, Version , Revision 1.1 (2022-12-07)
#### This script will not fully harden the OS programatically, there will be manual steps requried to become 100% STIG compliant.
#### Refer to https://github.com/usnistgov/macos_security and https://public.cyber.mil/stigs/ for more information.

#### USE AT YOUR OWN RISK #################

#v257149
# The macOS system must disable the SSHD service.
/usr/bin/sudo /bin/launchctl disable system/com.openssh.sshd

#v257158 / 6.1
#The macOS system must be configured so that log files must not contain access control lists (ACLs).
/bin/chmod -RN $(/usr/bin/awk -F: '/^dir/{print $2}' /etc/security/audit_control)

#v257159 / 6.2
#The macOS system must be configured so that log folders must not contain access control lists (ACLs).
/bin/chmod -N $(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}')

#v257174 / 6.5
#The macOS system must be configured with audit log files group-owned by wheel.
/usr/bin/chgrp -R wheel $(/usr/bin/grep '^dir' /etc/security/audit_control | /usr/bin/awk -F: '{print $2}')/*

#v257175 / 6.16
#The macOS system must be configured with audit log folders group-owned by wheel.
/usr/bin/chgrp wheel $(/usr/bin/awk -F : '/^dir/{print $2}' /etc/security/audit_control)

#v257185
#The macOS system must be configured to disable SMB File Sharing unless it is required.
/usr/bin/sudo /bin/launchctl disable system/com.apple.smbd

#v257186
#The macOS system must be configured to disable the Network File System (NFS) daemon unless it is required.
/usr/bin/sudo /bin/launchctl disable system/com.apple.nfsd

#v257189
#The macOS system must be configured to disable the UUCP service.
/usr/bin/sudo /bin/launchctl disable system/com.apple.uucp

#v257191
#The macOS system must be configured to disable Web Sharing.
/usr/bin/sudo /bin/launchctl disable system/org.apache.httpd

#v257201
#The macOS system must be configured to disable Remote Apple Events.
/usr/bin/sudo /bin/launchctl disable system/com.apple.AEServer

#v257207
#The macOS system must be configured to disable the tftp service.
/usr/bin/sudo /bin/launchctl disable system/com.apple.tftpd
