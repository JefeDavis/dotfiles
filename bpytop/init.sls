bpytop: pkg.installed

bpytop-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/bpytop
    - source: salt://bpytop/bpytop
    - makedirs: true
    - clean: true
    - user: {{ grains['user'] }}
