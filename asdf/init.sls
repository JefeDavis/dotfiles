asdf:
  pkg.installed

asdf-envs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/asdf
    - source: salt://asdf/env
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

asdf-direnv:
  cmd.run:
    - env:
        - ASDF_DATA_DIR: {{ pillar['xdg_data_home'] }}/asdf
    - name: source $(brew --prefix asdf)/libexec/asdf.sh && asdf plugin-add direnv
    - unless: source $(brew --prefix asdf)/libexec/asdf.sh && asdf plugin  list | grep direnv
    - runas: {{ grains['user'] }}
