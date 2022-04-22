yabai:
  pkg.installed

yabai-configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/yabai
    - source: salt://yabai/config
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}
    - force: true

yabai-scripts:
  file.recurse:
    - name: {{ pillar['xdg_lib_home'] }}/yabai
    - source: salt://yabai/lib
    - clean: true
    - makedirs: true
    - file_mode: 0755
    - user: {{ grains['user'] }}
    - force: true

yabai-service:
  cmd.run:
    - name: brew services restart yabai
    - runas: {{ grains['user'] }}
    - onchanges:
        - file: {{ pillar['xdg_config_home'] }}/yabai
