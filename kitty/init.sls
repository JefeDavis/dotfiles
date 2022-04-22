include:
  - fonts

kitty: 
  {% if grains['os'] == 'MacOS' %}
  cmd.run:
    - name: brew install kitty --cask
    - unless: brew list kitty --cask
    - runas: {{ grains['user'] }}
  {% else %}
  pkg.installed:
    - name: kitty
  {% endif %}

kitty-icon:
  file.managed:
    - name: /Applications/kitty.app/Contents/Resources/kitty.icns
    - source: salt://kitty/kitty-dark.icns
    - force: true
  cmd.run:
    - names: 
        - touch /Applications/kitty.app
        - "killall Finder && killall Dock"
    - onchanges:
        - file: /Applications/kitty.app/Contents/Resources/kitty.icns

configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/kitty
    - source: salt://kitty/config
    - clean: true
    - user: {{ grains['user'] }}

kitty-scripts:
  file.recurse:
    - name: {{ pillar['xdg_bin_home'] }}
    - source: salt://kitty/bin
    - makedir: true
    - file_mode: '0755'
    - user: {{ grains['user'] }}

remote-control:
  file.directory:
    - name: {{ pillar['xdg_cache_home'] }}/kitty
    - user: {{ grains['user'] }}
