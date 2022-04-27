nnn:
  git.cloned:
    - name: https://github.com/jarun/nnn
    - target: {{ pillar['xdg_data_home'] }}/nnn
    - user: {{ grains['user'] }}

trash-cli:
  pkg.installed

nnn-config:
  file.directory:
    - names:
        - {{ pillar['xdg_lib_home'] }}/nnn.d
        - {{ pillar['xdg_config_home'] }}/nnn
        - {{ pillar['xdg_cache_home'] }}/nnn/previews
    - makedirs: true
    - user: {{ grains['user'] }}

nnn-env:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/nnn
    - source: salt://nnn/env
    - clean: true
    - makedirs: true
    - template: jinja
    - user: {{ grains['user'] }}

nnn-wrapper:
  file.managed:
    - name: {{ pillar['xdg_bin_home'] }}/nnn
    - source: salt://nnn/bin/nnn
    - makedirs: true
    - mode: 0755
    - user: {{ grains['user'] }}

nnn-build:
  file.absent:
    - name: {{ pillar['xdg_lib_home'] }}/nnn.d/nnn
  cmd.run:
    - cwd: {{ pillar['xdg_data_home'] }}/nnn
    - names:
      - make O_NERD=1
      - mv nnn {{ pillar['xdg_lib_home'] }}/nnn.d/nnn
      - cp -r plugins {{ pillar['xdg_config_home'] }}/nnn
    - runas: {{ grains['user'] }}
    - user: {{ grains['user'] }}




# nnn-desktop:
#   file.managed:
#     - name: {{ pillar['xdg_data_home'] }}/applications/nnn.desktop
#     - template: jinja
#     - source: salt://nnn/nnn.desktop
