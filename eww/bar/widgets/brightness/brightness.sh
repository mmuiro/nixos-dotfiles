function get_brightness {
    brightnessctl g
}

function set_brightness {
    brightnessctl s $1
}

function follow_brightness {
    get_brightness
    eww update brightness_level=$(get_brightness)
    # you may need to change the brightness file path to match your machine
    inotifywait -q -m -e modify "/sys/class/backlight/amdgpu_bl0/actual_brightness" |
    while read -r _; do
        get_brightness
        eww update brightness_level=$(get_brightness)
    done
}

function open_brightness_menu {
    eww update brightness_menu_open=true
    eww open-many brightness-menu-closer brightness-menu
    # update the brightness value so that the scale is updated to the current value
    eww update brightness_level=$(get_brightness)

}

function close_brightness_menu {
    eww update brightness_menu_open=false
    eww close brightness-menu-closer && eww close brightness-menu
}

case "$1" in
    "get-brightness") get_brightness;;
    "set-brightness") set_brightness "$2";;
    "follow-brightness") follow_brightness;;
    "open-brightness-menu") open_brightness_menu;;
    "close-brightness-menu") close_brightness_menu;;
    *) echo "Invalid command." && exit 1;
esac
