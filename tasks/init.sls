include:
  - lang.rust

dijo:
  cmd.run:
    - name: cargo install dijo
    - runas: {{ grains['user'] }}

dijo-data:
  file.symlink:
    - target: {{ grains['homedir'] }}/Documents/Delta/habits
    - name: {{ grains['homedir'] }}/Library/Application Support/rs.nerdypepper.dijo
    - makedirs: true
    - user: {{ grains['user'] }}
    - force: True

dijo-config:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/dijo/config.toml
    - makedirs: True
    - user: {{ grains['user'] }}
    - contents:
        - "[look]"
        - true_chr = "●"
        - false_chr = "○"
        - future_chr = "◌"
        - "[colors]"
        - reached = "light cyan"
        - todo = "light red"
        - inactive = "#8A889D"
    - force: true

dijo-config-link:
  file.symlink:
    - name: {{ grains['homedir'] }}/Library/Application Support/rs.nerdypepper.dijo/config.toml
    - target: {{ pillar['xdg_config_home'] }}/dijo/config.toml
    - makedirs: true
    - user: {{ grains['user'] }}
    - force: true
    - require:
        - file: {{ pillar['xdg_config_home'] }}/dijo/config.toml
