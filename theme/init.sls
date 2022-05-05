current-theme:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/current-theme
    - contents: embark
    - replace: false
    - makedirs: true
    - user: {{ grains['user'] }}

themes:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/theme
    - source: salt://theme/config
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

functions:
  file.recurse:
    - name: {{ pillar[xdg_config_home'] }}/zsh/functions
    - source: salt://theme/functions
    - makedirs: true
    - file_mode: 0755
    - user: {{ grains['user'] }}

