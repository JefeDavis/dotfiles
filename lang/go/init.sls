go: pkg.installed

go-dir:
  file.directory:
    - name: {{ pillar['go_path'] }}
    - user: {{ grains['user'] }}

go-envs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/lang/go
    - source: salt://lang/go/env
    - clean: true
    - makedirs: true
    - template: jinja
    - user: {{ grains['user'] }}

go-pls:
  cmd.run:
    - name: go install golang.org/x/tools/gopls@latest
    - runas: {{ grains['user'] }}
    - env:
        - GOPATH: {{ pillar['go_path'] }}
