include:
  - lang.python

task: pkg.installed

{% set task_home = pillar['xdg_config_home'] + '/task' %}

task-configs:
  file.recurse:
    - name: {{ task_home }}
    - source: salt://taskwarrior/config
    - clean: true
    - makedirs: True
    - file_mode: keep
    - template: jinja
    - user: {{ grains['user'] }}

taskserver-root-cert-file:
  file.managed:
    - name: {{ task_home }}/root-cert.pem
    - contents_pillar: taskwarrior:taskd_root_cert
    - user: {{ grains['user'] }}

taskserver-cert-file:
  file.managed:
    - name: {{ task_home }}/cert.pem
    - contents_pillar: taskwarrior:taskd_cert
    - user: {{ grains['user'] }}

taskserver-key-file:
  file.managed:
    - name: {{ task_home }}/key.pem
    - contents_pillar: taskwarrior:taskd_key
    - user: {{ grains['user'] }}

tasklib:
  cmd.run:
  - name: pip3 install tasklib
  - runas: {{ grains['user'] }}
  - require:
      - pkg: python3

timewarrior: pkg.installed

task-sync-cron:
  cron.present:
    - identifier: "sync taskwarrior"
    - name: 'source $HOME/.zshenv && task sync'
    # every 10 minutes
    - minute: "*/10"
    - user: {{ grains['user'] }}
