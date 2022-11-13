#!/bin/bash
# The Sway configuration file in ~/.config/sway/config calls this script.

# uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)
linux_version=$(uname -r | cut -d '-' -f1)
# battery_status=$(cat /sys/class/power_supply/BAT0/status)
date_formatted=$(date "+(%a) %d-%b-%Y   %H:%M")

net() {
  SSID=$(nmcli -g GENERAL.CONNECTION dev show | tr -d '[:space:]')
  if [[ -z "$SSID" ]]; then
    ICON='🖧'
    SSID='eth'
  else
    ICON='󰤨'
  fi

  printf "$ICON %s" "$SSID"
}

sound() {

  local vol="$(pamixer --get-volume)"
  local muted="$(pamixer --get-mute)"

  # If muted, print 🔇 and exit.
  [ "$muted" = "true" ] && echo 🔇 && exit

  case 1 in
    $((vol >= 70)) ) icon="🔊" ;;
    $((vol >= 30)) ) icon="🔉" ;;
    $((vol >= 1)) ) icon="🔈" ;;
    * ) echo 🔇 && exit ;;
  esac

  printf "%s" "$icon $vol%"
}

# 💎 💻 💡 🔌 ⚡ 📁 ↑ 🔋\|
printf "%s" "🐧$linux_version   $(sound)  $date_formatted"

