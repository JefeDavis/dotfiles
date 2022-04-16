starship: pkg.installed

starship-config:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/starship.toml
    - source: salt://starship/starship.toml
    - makedirs: True
    - user: {{ grains['user'] }}
