include:
  - lang.go

{% set tmux_dir = pillar['xdg_config_home'] + '/tmux' %}

tmux: pkg.installed

tmux-config:
  file.recurse:
    - name: {{ tmux_dir }}
    - source: salt://tmux/config
    - makedirs: true
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

tmux-scripts:
  file.recurse:
    - name: {{ pillar['xdg_bin_home'] }}
    - source: salt://tmux/bin
    - makedirs: true
    - file_mode: '0755'
    - user: {{ grains['user'] }}
    - force: true
