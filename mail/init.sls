include:
  - passwords
  - lang.go

neomutt: pkg.installed

neomutt-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/neomutt
    - clean: true
    - source: salt://mail/neomutt
    - user: {{ grains['user'] }}

mail-oauth:
  file.managed:
    - name: {{ grains['homedir'] }}/.local/bin/mail_oauth2.py
    - source: salt://mail/scripts/mail_oauth2.py
    - user: {{ grains['user'] }}
    - mode: '0755'

maildirs:
  file.directory:
    - names:
        - {{ pillar['xdg_data_home'] }}/Mail/VMware
        - {{ pillar['xdg_cache_home'] }}/mutt
    - user: {{ grains['user'] }}
