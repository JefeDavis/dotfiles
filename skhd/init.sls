skhd: 
  pkg.installed:
    - name: skhd

skhd-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/skhd
    - source: salt://skhd/config
    - makedirs: true
    - clean: true
    - user: {{ grains['user'] }}
    - force: true

skhd-service:
  cmd.run:
    - name: brew services restart skhd
    - use_vt: true
    - onchanges:
        - file: {{ pillar['xdg_config_home'] }}/skhd

