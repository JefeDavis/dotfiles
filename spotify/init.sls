spotify-tui:
  pkg.installed

spt-configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/spotify-tui
    - source: salt://spotify/config
    - clean: false
    - makedirs: true
    - user: {{ grains['user'] }}

