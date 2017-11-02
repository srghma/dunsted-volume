#!/bin/sh

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

# https://nixos.org/nixos/manual/#sec-custom-packages
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

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
  notify-send -i audio-volume-muted-blocking -t 8 -a $app_id -u normal "    $bar"
}

case $1 in
  up)
    # Set the volume on (if it was muted)
    amixer set Master on > /dev/null
    # Up the volume (+ 5%)
    amixer sset Master 5%+ > /dev/null
    send_notification
    ;;
  down)
    amixer set Master on > /dev/null
    amixer sset Master 5%- > /dev/null
    send_notification
    ;;
  mute)
        # Toggle mute
    amixer set Master 1+ toggle > /dev/null
    if is_mute ; then
        notify-send -i audio-volume-muted -t 8 -r $app_id -u normal "Mute"
    else
        send_notification
    fi
    ;;
esac
