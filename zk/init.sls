include:
  - lang.go
  - cli-utils
  - zsh

zk: pkg.installed

zk-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/zk
    - source: salt://zk/config
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

zk-env:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/zk
    - source: salt://zk/env
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

zk-functions:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/zsh/functions
    - source: salt://zk/functions
    - makedirs: true
    - file_mode: 0755
    - user: {{ grains['user'] }}
