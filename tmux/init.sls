include:
  - lang.go

{% set tmux_dir = pillar['xdg_config_home'] + '/tmux' %}

tmux: pkg.installed

tmux-config:
  file.managed:
    - name: {{ tmux_dir }}/tmux.conf
    - source: salt://tmux/tmux.conf
    - makedirs: true
    - user: {{ grains['user'] }}

embark-tmux:
  file.managed:
    - name: {{tmux_dir }}/embark.tmux
    - source: salt://tmux/embark.tmux
    - makerdirs: true
    - user: {{ grains['user'] }}

gruvbox-light-tmux:
  file.managed:
    - name: {{tmux_dir }}/gruvbox-light.tmux
    - source: salt://tmux/gruvbox-light.tmux
    - makerdirs: true
    - user: {{ grains['user'] }}

neoline:
  file.managed:
    - name: {{tmux_dir }}/neoline.tmux
    - source: salt://tmux/neoline.tmux
    - makerdirs: true
    - user: {{ grains['user'] }}

tmux-plugin-manager:
  git.cloned:
    - name: https://github.com/tmux-plugins/tpm
    - target: {{ tmux_dir }}/plugins/tpm
    - user: {{ grains['user'] }}

tmuxinator:
  pkg.installed:
    - name: tmuxinator
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/tmuxinator
    - source: salt://tmux/tmuxinator
    - makedirs: true
    - user: {{ grains['user'] }}
    - force: true

tmux-launcher:
  file.managed:
    - name: {{ grains['homedir'] }}/.local/bin/embark.sh
    - source: salt://tmux/embark.sh
    - user: {{ grains['user'] }}
    - mode: '0755'
    - force: true
