# vim:ft=sh
{% set config_home = pillar['xdg_config_home'] %}

ZDOTDIR={{ pillar['xdg_config_home'] }}/zsh

# XDG Base directory
XDG_CONFIG_HOME={{ pillar['xdg_config_home'] }}
XDG_DATA_HOME={{ pillar['xdg_data_home'] }}
XDG_CACHE_HOME={{ pillar['xdg_cache_home'] }}

GNUPGHOME={{ pillar['xdg_config_home'] }}/gpg
GPG_TTY="$TTY"
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

PASSWORD_STORE_DIR={{ pillar['xdg_data_home'] }}/password-store
# PASSWORD_STORE_GPG_OPTS="--no-throw-keyids"
PASSWORD_STORE_ENABLE_EXTENSIONS=true
