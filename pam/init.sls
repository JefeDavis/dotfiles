# Allow touchid to authenticate sudo

# needed for tmux sessions
pam-reattach: pkg.installed

pam-sudo:
  file.managed:
    - name: /etc/pam.d/sudo
    - source: salt://pam/sudo
