include:
  - gpg

git: pkg.installed

git-configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/git
    - source: salt://git/config
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

git-scripts:
  file.recurse:
    - name: {{ pillar['xdg_bin_home'] }}
    - source: salt://git/bin
    - makedirs: true
    - file_mode: 0755
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
