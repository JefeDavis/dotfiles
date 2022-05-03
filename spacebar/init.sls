include:
  - yabai
  - fonts

spacebar:
  pkg.installed:
    - name: "cmacrae/formulae/spacebar"

spacebar-configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/spacebar
    - source: salt://spacebar/config
    - clean: true
    - makedirs: true
    - file_mode: 0755
    - user: {{ grains['user'] }}


spacebar-service:
  cmd.run:
    - name: brew services restart spacebar
    - runas: {{ grains['user'] }}
    - onchanges:
        - file: {{ pillar['xdg_config_home'] }}/spacebar
