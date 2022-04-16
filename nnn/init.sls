nnn:
  git.cloned:
    - name: https://github.com/jarun/nnn
    - target: {{ pillar['xdg_data_home'] }}/nnn
    - user: {{ grains['user'] }}

trash-cli:
  pkg.installed

nnn-config:
  file.directory:
    - name: {{ pillar['xdg_config_home'] }}/nnn
    - makedirs: true
    - user: {{ grains['user'] }}

nnn-build:
  file.absent:
    - name: {{ grains['homedir'] }}/.local/bin/nnn
  cmd.run:
    - cwd: {{ pillar['xdg_data_home'] }}/nnn
    - names:
      - make O_NERD=1
      - mv nnn {{ grains['homedir'] }}/.local/bin
      - cp -r plugins {{ pillar['xdg_config_home'] }}/nnn
    - user: {{ grains['user'] }}


# nnn-desktop:
#   file.managed:
#     - name: {{ pillar['xdg_data_home'] }}/applications/nnn.desktop
#     - template: jinja
#     - source: salt://nnn/nnn.desktop
