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

  #Configure options for gmail
  options = { :address              => "smtp.gmail.com",
              :port                 => 587,
              :domain               => 'gmail.com',
              :user_name            => 'cirrusmioat',
              :password             => 'soserious',
              :authentication       => 'plain',
              :enable_starttls_auto => true  }

  #Apply options
  Mail.defaults do
    delivery_method :smtp, options
  end

  #Send a test message
  Mail.deliver do
	to 'tyler.shipp@uky.edu'
      from 'cirrusmioat@gmail.com'
   subject 'testing sendmail'
      body 'testing sendmail'
  end


  #curl -sG --data-urlencode "token=$token" \
  #         --data-urlencode "words=$words" "${url}/doorwatch"

#	^^^^May need significant rework
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