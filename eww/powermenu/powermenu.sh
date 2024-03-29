function get_uptime {
    uptime | sed -r 's/\S+\s+\S+\s+(\S+),\s+.+/\1/'| sed -r 's/([0-9]+):0*([0-9]{1,2})/\1 hrs \2 mins/'
}

function open_powermenu {
    system_uptime=$(get_uptime)
    eww update uptime="$system_uptime" powermenu_open="true"
    eww open-many powermenu-closer powermenu
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
    eww update powermenu_open="false"
    eww close powermenu && eww close powermenu-closer
}

function run_powermenu_cmd {
    close_powermenu
    case $1 in
        "suspend") systemctl-suspend;;
        "reboot") reboot;;
        "shutdown") shutdown -h now;;
        "logout") exit;;
        # todo - add a logout option using exit
        *) echo "Invalid powermenu command." && exit 1;
    esac
}

case $1 in
    "set-hovered-powermenu-item") set_hovered_powermenu_item $2;;
    "open-powermenu") open_powermenu;;
    "close-powermenu") close_powermenu;;
    "toggle-powermenu") toggle_powermenu;;
    "get-uptime") get_uptime;;
    "run-powermenu-cmd") run_powermenu_cmd $2;;
    *) echo "Invalid command." && exit 1;
esac
