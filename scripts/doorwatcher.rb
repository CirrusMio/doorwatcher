# Return an error
_door_error() {
  echo -e ">>> ERROR: $*" >&2
  exit 1
}

# Return a token
_door_token() {
  url="$(_door_fetch "url")"
  curl -G "${url}/token"
}

# Generate door gif
_door_watch() {
  token="$(__door_fetch "token")"
  [ ! "$token" ] && _door_error "Please set your token in your .ains file."
  #words="$(echo "$@" | sed 's/ /\+/g')"
  _door_capture()
  _door_gif()
  _door_email()

}

# Print out usage info
_door_usage() {
  cat << EOF
Usage: door action
actions:
    token - fetch a token
    ? - ?
    h - print usage
EOF
}

# Fetch a value from the config file
_door_fetch() {
  key="$1"; shift
  awk -F ': ' "/${key}/ { print \$2 }" "$door_config"
}

# Exit if there is no configuration file
door_config="$HOME/.door"
[ ! "$door_config" ]  && _door_error "Configuration file not found."

action="$1"
case "$action" in
  token) _door_token;;
  watch) _door_watch;;
  h) _door_usage;;
  *) _door_usage;;
esac

exit 0