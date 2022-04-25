k9s: pkg.installed

k9s-configs:
  file.recurse:
    - name: {{ pillar["xdg_config_home"] }}/k9s
    - source: salt://k9s/config
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

