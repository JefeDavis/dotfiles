include:
  - gpg

git: pkg.installed

gitconfig:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/git/config
    - source: salt://git/gitconfig
    - makedirs: true
    - user: {{ grains['user'] }}

gitignore:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/git/gitignore
    - source: salt://git/gitignore
    - makedirs: true
    - user: {{ grains['user'] }}

git-branches:
  file.managed:
    - name: {{ grains['homedir'] }}/.local/bin/git-branches
    - source: salt://git/git-branches
    - mode: keep
    - user: {{ grains['user'] }}

git-default-branch:
  file.managed:
    - name: {{ grains['homedir'] }}/.local/bin/git-default-branch
    - source: salt://git/git-default-branch
    - mode: keep
    - user: {{ grains['user'] }}

gh: pkg.installed

github-cli-dash:
  cmd.run:
    - name: gh extension install dlvhdr/gh-dash
    - runas: {{ grains['user'] }}
    - unless: gh dash --help
    - require:
      - pkg: gh
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/gh-dash/config.yml
    - source: salt://git/gh-dash.config.yml
    - makedirs: true
    - user: {{ grains['user'] }}
