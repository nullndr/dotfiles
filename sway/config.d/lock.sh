#! /bin/sh

exec swayidle -w \
  timeout 300 'swaylock -l -f -i "/home/andrea/Desktop/wallpaper/QMotVCF.jpeg"' \
  # timeout 600 'swaymsg "output * dpms off"' \ 
  # resume 'swaymsg "output * dpms on"' \
  before-sleep 'playerctl pause' \
  before-sleep 'swaylock -l -f -i "/home/andrea/Desktop/wallpaper/QMotVCF.jpeg"'
