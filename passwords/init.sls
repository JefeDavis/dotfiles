include:
  - gpg

gopass: pkg.installed

pass-envs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/pass
    - source: salt://passwords/env
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}
    

gopass-jsonapi:
  pkg.installed:
    - name: gopass-jsonapi
  cmd.run:
    - name: echo "Y" | gopass-jsonapi configure --browser firefox --global=false --path {{ pillar['xdg_config_home'] }}/gopass --print=false
    - runas: {{ grains['user'] }}
    - creates: {{ pillar['xdg_config_home'] }}/gopass/gopass_wrapper.sh

passstore:
  git.cloned:
    - name: git@github.com:jefeDavis/password-store.git
    - target: {{ pillar['xdg_data_home'] }}/password-store
    - user: {{ grains['user'] }}
    - require:
      - pkg: gopass

summon:
  pkg.installed:
    - name: cyberark/tools/summon

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
    
