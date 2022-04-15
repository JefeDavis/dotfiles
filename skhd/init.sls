skhd: 
  pkg.installed:
    - name: skhd

skhd-config:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/skhd/skhdrc
    - source: salt:///skhd/skhdrc
    - makedirs: true
    - user: {{ grains['user'] }}
    - force: true

skhd-service:
  cmd.run:
    - name: brew services restart skhd
    - use_vt: true
    - onchanges:
        - file: {{ pillar['xdg_config_home'] }}/skhd/skhdrc

