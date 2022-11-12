#!/bin/bash
# The Sway configuration file in ~/.config/sway/config calls this script.

# uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)
linux_version=$(uname -r | cut -d '-' -f1)
# battery_status=$(cat /sys/class/power_supply/BAT0/status)
date_formatted=$(date "+%a %F %H:%M")

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

# 💎 💻 💡 🔌 ⚡ 📁 ↑ 🔋\|
printf "%s" "🐧$linux_version   $(net)   $date_formatted"

