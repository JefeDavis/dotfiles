gpg:
  pkg.installed
  # pkg.installed:
  #   - name: gnupg@2.2
  # cmd.run:
  #   - name: brew link gnupg@2.2
  #   - runas: {{ grains['user'] }}

gpg-config:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/gpg
    - source: salt://gpg/config
    - makedirs: true
    - dir_mode: 700
    - file_mode: 600
    - user: {{ grains['user'] }}
  cmd.run:
    - name: killall pinentry-mac gpg-agent
    - onchanges:
        - file: {{ pillar['xdg_config_home'] }}/gpg

gpg-envs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/gpg
    - source: salt://gpg/env
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

pinentry-mac:
  pkg.installed:
    - name: pinentry-mac
  cmd.run:
    - name: defaults write org.gpgtools.pinentry-mac UseKeychain -bool NO
  file.symlink:
    - name: /usr/local/opt/pinentry/bin/pinentry
    - target: /usr/local/bin/pinentry-mac
    - user: {{ grains['user'] }}

pinentry-touchid:
  pkg.installed:
    - name: jorgelbg/tap/pinentry-touchid
  cmd.run:
    - name: defaults write org.gpgtools.pinentry-touchid UseKeychain -bool NO

personal-gpg-key:
  gpg.present:
    - keys: EAC7ED8E94BAAD5568B08A2A9338B393AD901289
      keyserver: keys.openpgp.org
    - user: {{ grains['user'] }}
    - gnupghome: {{ pillar['xdg_config_home'] }}/gpg
    - trust: "ultimately"

work-gpg-key:
  gpg.present:
    - keys: D7B192A5CE8B6040DF689849E13C40350410CD91
    - user: {{ grains['user'] }}
    - gnupghome: {{ pillar['xdg_config_home'] }}/gpg
    - trust: "ultimately"


