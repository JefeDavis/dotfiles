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

nnn-build:
  file.absent:
    - name: {{ pillar['xdg_bin_home'] }}/nnn
  cmd.run:
    - cwd: {{ pillar['xdg_data_home'] }}/nnn
    - names:
      - make O_NAMEFISRT=1 O_NERD=1
      - mv nnn {{ pillar['xdg_bin_home'] }}/nnn
      - cp -r plugins {{ pillar['xdg_config_home'] }}/nnn
    - runas: {{ grains['user'] }}
    - user: {{ grains['user'] }}
