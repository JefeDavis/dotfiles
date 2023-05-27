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

# Lets all zsh files be in .config/zsh
zsh-root-env:
  file.managed:
    - name: /etc/zsh/zshenv
    - source: salt://zsh/zsh_root_env
    - makedirs: true

zsh-config:
  file.recurse:
    - name: {{ zsh_dir }}
    - source: salt://zsh/config
    - user: {{ grains['user'] }}
    - force: True
    - file_mode: keep
    - requres:
        - pkgs:
            - starship
            - direnv

histfile:
  file.directory:
    - name: {{ pillar['xdg_data_home'] }}/zsh
    - user: {{ grains['user'] }}

zsh-plugins-dir:
  file.directory:
    - name: {{ zsh_dir }}/plugins
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
