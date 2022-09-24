#!/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors
. ~/.config/chadwm/scripts/bar_themes/onedark

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
  # updates=$(doas xbps-install -un | wc -l) # void
  updates=$(checkupdates | wc -l)   # arch
  # updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

  if [ -z "$updates" ]; then
    printf "  ^c$green^    Fully Updated"
  else
    printf "  ^c$green^    $updates"" updates"
  fi
}

battery() {
  for battery in /sys/class/power_supply/BAT?
  do
    # Get its remaining capacity and charge status.
    capacity=$(cat "$battery"/capacity) || break
    [ "$capacity" -le 100 ] && baticon="$(echo -e "")"
    [ "$capacity" -le 75 ] && baticon="$(echo -e "")"
    [ "$capacity" -le 50 ] && baticon="$(echo -e "")"
    [ "$capacity" -le 25 ] && baticon="$(echo -e "")"
    [ "$capacity" -le 10 ] && baticon="$(echo -e "")"

    status=$(cat "$battery"/status) || break

    [ "$status" = "Discharging" ] && icon=" $baticon"
    [ "$status" != "Discharging" ] && icon=""
  done
  printf "^c$blue^ $icon $capacity"
}

mem() {
  printf "^c$blue^^b$black^  "
  printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

net() {
	if [[ "$(cat /sys/class/net/*/operstate 2>/dev/null)" == *"up"* ]]; then
    printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Connected"
  else
    printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Disconnected"
  fi
}

clock() {
	printf "^c$black^ ^b$darkblue^ 󱑆 "
	printf "^c$black^^b$blue^ $(date '+%H:%M')  "
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$updates $(battery) $(cpu) $(mem) $(net) $(clock)"
done
