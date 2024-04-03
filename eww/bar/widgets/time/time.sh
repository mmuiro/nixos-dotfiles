function toggle_calendar {
    if [ $(eww get calendar_open) == "true" ];
    then
        close_calendar
    else
        open_calendar
    fi
}

function open_calendar {
    eww update calendar_open="true"
    eww open-many calendar-closer calendar
}

function close_calendar {
    eww update calendar_open="false"
    eww close calendar && eww close calendar-closer
}

case $1 in
    "open-calendar") open_calendar;;
    "close-calendar") close_calendar;;
    "toggle-calendar") toggle_calendar;;
    *) echo "Invalid command." && exit 1;
esac
