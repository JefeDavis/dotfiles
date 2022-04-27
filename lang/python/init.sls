python3: pkg.installed

pyyaml: 
  cmd.run:
  - name: pip3 install pyyaml
  - runas: {{ grains['user'] }}
  - require:
      - pkg: python3
