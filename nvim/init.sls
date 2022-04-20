include:
  - lang.lua

nvim:
  pkg.installed:
    - name: nvim
    - options: [ "--HEAD" ]

vim-packer:
  git.cloned:
    - name: https://github.com/wbthomason/packer.nvim
    - target: {{ pillar['xdg_data_home'] }}/nvim/site/pack/packager/opt/packer.nvim
    - user: {{ grains['user'] }}

nvim-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/nvim
    - source: salt://nvim/nvim
    - clean: true
    - user: {{ grains['user'] }}
    - force: true
  cmd.run:
    - name: nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    - runas: {{ grains['user'] }}
    - shell: /bin/zsh

