neofetch: pkg.installed

neofetch-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/neofetch
    - source: salt://neofetch/config
    - makedirs: true
    - clean: true
    - user: {{ grains['user'] }}
