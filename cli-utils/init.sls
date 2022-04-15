ripgrep:
  pkg.installed

skim:
  {% if grains['os'] == 'MacOS' %}
  cmd.run:
    - name: brew install skim --cask
    - unless: brew list skim --cask
    - runas: {{ grains['user'] }}
  {% else %}
  pkg.installed
  {% endif %}

fzf:
  pkg.installed

jq:
  pkg.installed
