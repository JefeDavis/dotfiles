go: pkg.installed

go-dir:
  file.directory:
    - name: {{ pillar['go_path'] }}

go-pls:
  cmd.rum:
    - name: go install golang.org/x/tools/gopls@latest
    - runas: {{ grains['user'] }}
    - env:
        - GOPATH: {{ pillar['go_path'] }}
