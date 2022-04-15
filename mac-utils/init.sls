# This file is for small command line utils that don't have config files
# and I can just condense them to one spot
ripgrep:
  pkg.installed:
    - name: rg
    - unless: brew list rg

neofetch:
  pkg.installed:
    - name: neofetch
    - unless: brew list neofetch

sk:
  pkg.installed:
    - name: sk

tree:
  pkg.installed:
    - name: tree
    - unless: brew list tree

watch:
  pkg.installed:
    - name: watch
    - unless: brew list watch
