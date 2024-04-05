# ignore error messages
exec 2> /dev/null

function get_profiles {
    local json
    local profiles
    json="["
    profiles=$(powerprofilesctl list | rg -oU "\s+(.+):\n\s+Driver:" -r '$1' | rg -o "(\*\s+)*(.+)" -r '$2')
    while read -r line; do
        json+="\"$line\","
    done <<< "$(echo "$profiles")"
    json="${json::-1}]"
    echo $json
}

function get_active_profile {
    powerprofilesctl get
}

function follow_active_profile {
    get_active_profile
    dbus-monitor --system "path='/net/hadess/PowerProfiles'" 2> /dev/null | rg --line-buffered "member=PropertiesChanged" |
    while read -r _; do
        get_active_profile
    done
}

function set_active_profile {
    powerprofilesctl set "$1"
}

function get_status {
    acpi -b | rg -o "Battery 0: (Discharging|Not charging|Charging), [0-9]{1,3}%(, ([0-9][0-9]:[0-9][0-9]:[0-9][0-9]))*" -r '{"status": "$1", "remaining_time": "$3"}'
}

function get_battery_life {
    acpi -b | rg -o "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"
}

function open_battery_menu {
    eww update battery_menu_open="true" battery_life="$(get_battery_life)"
    eww open-many battery-menu-closer battery-menu
}

function close_battery_menu {
    eww update battery_menu_open="false"
    eww close battery-menu && eww close battery-menu-closer
}

# function check_battery {
#     local battery
#     battery="$(acpi -b | rg -o "([0-9]{1,3})%" -r '$1')"
#     if (( battery < 20 )); then
#         notify-send "Low battery: $battery%!
# Lowering brightness to the minimum level."
#         brightnessctl -s 0
#     fi
# }

case "$1" in
    "get-profiles") get_profiles;;
    "get-active-profile") get_active_profile;;
    "follow-active-profile") follow_active_profile;;
    "set-active-profile") set_active_profile "$2";;
    "status") get_status;;
    "get-battery-life") get_battery_life;;
    "open-battery-menu") open_battery_menu;;
    "close-battery-menu") close_battery_menu;;
    # "check_battery") check_battery;;
    *) echo "Invalid command.";;
esac
