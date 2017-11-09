#!@bash@/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

# code stolen from
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

PATH=@coreutils@/bin:@alsaUtils@/bin:@libnotify@/bin${PATH:+:$PATH}

appid='dunsted-volume'

function get_volume {
  amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
  volume=`get_volume`
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
  # Send the notification
  notify-send --icon=audio-volume-medium --expire-time=8 --app-name=$app_id --urgency=normal "    $bar"
}

case $1 in
  up)
    amixer set Master on > /dev/null
    amixer -c0 set Master 5%+ > /dev/null
    send_notification
    ;;
  down)
    amixer set Master on > /dev/null
    amixer -c0 set Master 5%- > /dev/null
    send_notification
    ;;
  mute)
    # Toggle mute
    amixer set Master 1+ toggle > /dev/null
    if is_mute ; then
      notify-send --icon=audio-volume-muted --expire-time=8 --app-name=$app_id --urgency=normal "Mute"
    else
      send_notification
    fi
    ;;
esac
