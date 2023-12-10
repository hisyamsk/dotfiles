#!/bin/bash

# options to be displayed
option0="screen"
option1="area"
option2="window"

# options to be displyed
options="$option0\n$option1\n$option2"

selected="$(echo -e "$options" | rofi -lines 3 -dmenu -p "scrot")"
case $selected in
    $option0)
        sleep 0.5
        maim ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png;;
    $option1)
        maim -s ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png;;
        # cd ~/$(xdg-user-dir PICTURES)/ && scrot -s;;
    $option2)
        cd ~/$(xdg-user-dir PICTURES)/ && sleep 1 && scrot -u;;
esac
