include:
  - lang.lua
  - lang.python

nvim:
  pkg.installed:
    - name: nvim
    - options: [ "--HEAD" ]

pynvim:
  cmd.run:
  - name: pip3 install pynvim
  - runas: {{ grains['user'] }}
  - require:
      - pkg: python3

vim-packer-missing:
  file.absent:
    - name: {{ pillar['xdg_data_home'] }}/nvim/site/pack/packager/opt/packer.nvim

nvim-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/nvim
    - source: salt://nvim/config
    - clean: true
    - makedir: true
    - user: {{ grains['user'] }}
    - force: true
  cmd.run:
    - name: nvim --headless -c 'autocmd User LazySync quitall' -c 'Lazy sync'
    - runas: {{ grains['user'] }}
    - shell: /bin/zsh

