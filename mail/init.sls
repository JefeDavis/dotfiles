include:
  - passwords
  - lang.go

neomutt: pkg.installed

neomutt-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/neomutt
    - clean: true
    - source: salt://mail/neomutt/config
    - user: {{ grains['user'] }}

mail-oauth:
  file.recurse:
    - name: {{ pillar['xdg_lib_home'] }}/neomutt
    - source: salt://mail/neomutt/lib
    - clean: true
    - makedirs: true
    - file_mode: '0755'
    - user: {{ grains['user'] }}

maildirs:
  file.directory:
    - names:
        - {{ pillar['xdg_data_home'] }}/Mail/VMware
        - {{ pillar['xdg_cache_home'] }}/mutt
    - user: {{ grains['user'] }}
