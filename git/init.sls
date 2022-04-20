include:
  - gpg

git: pkg.installed

git-configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/git/
    - source: salt://git/git
    - clean: true
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

gh-dash-configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/gh-dash
    - source: salt://git/gh-dash
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}
