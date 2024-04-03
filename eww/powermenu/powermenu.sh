MIN_POWERMENU_ITEM=0
MAX_POWERMENU_ITEM=3

function get_uptime {
    uptime | sed -r 's/\S+\s+\S+\s+(\S+),\s+.+/\1/'| sed -r 's/([0-9]+):0*([0-9]{1,2})/\1 hrs \2 mins/'
}

function open_powermenu {
    system_uptime=$(get_uptime)
    eww update uptime="$system_uptime" powermenu_open="true"
    eww open-many powermenu-closer powermenu
    hyprctl dispatch submap powermenu
}

function toggle_powermenu {
    if [ $(eww get powermenu_open) == "true" ];
    then
        close_powermenu
    else
        open_powermenu
    fi
}

function close_powermenu {
    eww update powermenu_open="false" selected_powermenu_item="0"
    eww close powermenu && eww close powermenu-closer
    hyprctl dispatch submap reset
}

function run_powermenu_cmd {
    close_powermenu
    case $1 in
        "suspend") systemctl suspend;;
        "reboot") reboot;;
        "shutdown") shutdown -h now;;
        "logout") exit;;
        *) echo "Invalid powermenu command." && exit 1;
    esac
}

function run_selected_item {
    powermenu_items=("logout" "suspend" "reboot" "shutdown")
    run_powermenu_cmd ${powermenu_items[$(eww get selected_powermenu_item)]}
}

function set_selected_item {
    eww update selected_powermenu_item="$1"
}

function inc_selected_item {
    curr_powermenu_item=$(eww get selected_powermenu_item)
    if [ $curr_powermenu_item -lt $MAX_POWERMENU_ITEM ]; then
        set_selected_item $(expr $curr_powermenu_item + 1)
    fi
}

function dec_selected_item {
    curr_powermenu_item=$(eww get selected_powermenu_item)
    if [ $curr_powermenu_item -gt $MIN_POWERMENU_ITEM ]; then
        set_selected_item $(expr $curr_powermenu_item - 1)
    fi
}

case $1 in
    "set-selected-item") set_selected_item $2;;
    "inc-selected-item") inc_selected_item;;
    "dec-selected-item") dec_selected_item;;
    "run-selected-item") run_selected_item;;
    "open-powermenu") open_powermenu;;
    "close-powermenu") close_powermenu;;
    "toggle-powermenu") toggle_powermenu;;
    "get-uptime") get_uptime;;
    "run-powermenu-cmd") run_powermenu_cmd $2;;
    *) echo "Invalid command." && exit 1;
esac
