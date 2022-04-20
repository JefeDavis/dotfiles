include:
  - cli-utils
  - starship
  - direnv

{% set zsh_dir = pillar['xdg_config_home'] + "/zsh" %}

zsh:
  pkg.installed

purge-oh-my-zsh:
  file.absent:
    - names:
        - {{ pillar['xdg_config_home'] }}/oh-my-zsh
        - {{ pillar['xdg_config_home'] }}/.oh-my-zsh
        - {{ grains['homedir'] }}/.oh-my-zsh

zsh-env:
  file.managed:
    - name: {{ grains['homedir'] }}/.zshenv
    - source: salt://zsh/.zshenv
    - user: {{ grains['user'] }}
    - template: jinja

zsh-config:
  file.recurse:
    - name: {{ zsh_dir }}
    - source: salt://zsh/zsh
    - user: {{ grains['user'] }}
    - force: True
    - requres:
        - pkgs:
            - starship
            - direnv


histfile:
  file.directory:
    - name: {{ pillar['xdg_data_home'] }}/zsh
    - user: {{ grains['user'] }}

zsh-syntax-highlighting:
  git.cloned:
    - name: https://github.com/zsh-users/zsh-syntax-highlighting
    - target: {{ zsh_dir }}/plugins/zsh-syntax-highlighting
    - user: {{ grains['user'] }}

zsh-autosuggestions:
  git.cloned:
    - name: https://github.com/zsh-users/zsh-autosuggestions
    - target: {{ zsh_dir }}/plugins/zsh-autosuggestions
    - user: {{ grains['user'] }}

zsh-vim-mode:
  git.cloned:
    - name: https://github.com/softmoth/zsh-vim-mode
    - target: {{ zsh_dir }}/plugins/zsh-vim-mode
    - user: {{ grains['user'] }}

zsh-fzf-tab:
  git.cloned:
    - name: https://github.com/Aloxaf/fzf-tab
    - target: {{ zsh_dir }}/plugins/fzf-tab
    - user: {{ grains['user'] }}

shell-scripts:
  file.recurse:
    - name: {{ grains['homedir'] }}/.local/bin
    - source: salt://zsh/scripts
    - file_mode: keep
    - user: {{ grains['user'] }}
    - force: True
