tmux-256color:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/terminfo
    - source: salt://terminfo/config/
    - makedirs: true
    - clean: true
    - user: {{ grains['user'] }}
  cmd.run:
    - name: "tic -xe tmux-256color $HOME/.config/terminfo/tmux-256color"
    - user: {{ grains['user'] }}
