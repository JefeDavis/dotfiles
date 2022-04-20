bash-profile:
  file.managed:
    - name: {{ grains['homedir'] }}/.bash_profile
    - source: salt://env/.bash_profile
    - template: jinja
    - makedirs: true
    - user: {{ grains['user'] }}
