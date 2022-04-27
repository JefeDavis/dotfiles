rust: pkg.installed

rust-envs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/lang/rust
    - source: salt://lang/rust/env
    - clean: true
    - makedirs: true
    - template: jinja
    - user: {{ grains['user'] }}
