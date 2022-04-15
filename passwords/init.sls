include:
  - gpg

gopass: pkg.installed

passstore:
  git.cloned:
    - name: git@github.com:jefeDavis/password-store.git
    - target: {{ pillar['xdg_data_home'] }}/password-store
    - user: {{ grains['user'] }}
    - require:
      - pkg: gopass

# pass-otp: pkg.installed

# zbar: pkg.installed

# browserpass:
#   pkg.installed:
#     - name: browserpass
#     - taps: amar1729/formulae
#   cmd.run:
#     - name: make PREFIX=/usr/local hosts-firefox-user
#     - cwd: /usr/local/lib/browserpass/
#     - runas: {{ grains['user'] }}
    
