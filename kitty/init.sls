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

configs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/kitty
    - source: salt://kitty/kitty
    - user: {{ grains['user'] }}
