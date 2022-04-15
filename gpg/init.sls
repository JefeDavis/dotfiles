gpg:
  pkg.installed
  # pkg.installed:
  #   - name: gnupg@2.2
  # cmd.run:
  #   - name: brew link gnupg@2.2
  #   - runas: {{ grains['user'] }}

gpg-config-dir:
  file.directory:
    - name: {{ pillar['xdg_config_home'] }}/gpg
    - user: {{ grains['user'] }}
    - dir_mode: 700
    - file_mode: 600

gpg-agent-config:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/gpg/gpg-agent.conf
    - source: salt://gpg/gpg-agent.conf
    - user: {{ grains['user'] }}

my-gpg-key:
  gpg.present:
    - keys: EAC7ED8E94BAAD5568B08A2A9338B393AD901289
      keyserver: keys.openpgp.org
    - user: {{ grains['user'] }}
    - gnupghome: {{ pillar['xdg_config_home'] }}/gpg
    - trust: "ultimately"


