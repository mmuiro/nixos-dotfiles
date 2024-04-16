function set_volume {
    pactl set-sink-volume @DEFAULT_SINK@ $1
}

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | rg -o "([0-9]{1,2})%" -r '$1' | head -n 1
}

# TODO: merge source follows into one function
function follow_source_volume {
    get_volume
    pactl subscribe |
    rg --line-buffered "Event 'change' on source (.+)" |
    while read -r _; do
        get_volume
    done 
}

function follow_sink_volume {
    get_volume
    pactl subscribe |
    rg --line-buffered "Event 'change' on sink (.+)" |
    while read -r _; do
        get_volume
    done 
}

function get_muted {
    if [ $(pactl get-sink-mute @DEFAULT_SINK@ | rg "^Mute: (yes|no)" -r '$1') == "yes" ]
    then
        echo true
    else
        echo false
    fi
}

function follow_source_muted {
    get_muted
    pactl subscribe |
    rg --line-buffered "Event 'change' on source (.+)" |
    while read -r _; do
        get_muted
    done 
}

function follow_sink_muted {
    get_muted
    pactl subscribe |
    rg --line-buffered "Event 'change' on source (.+)" |
    while read -r _; do
        get_muted
    done 
}

function toggle_muted {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

function get_audio_outputs {
    local outputs
    local json
    outputs=$(pactl list sinks | rg -oU "Sink #(\d+)\n.*\n.*\n.*Description: (.+)" -r '{"name": "$2", "id": $1}')
    json="["
    while read -r line; do 
        json+="$line," 
    done <<< "$(echo "$outputs")"
    json="${json::-1}]"
    echo $json
}

function follow_audio_outputs {
    get_audio_outputs
    pactl subscribe |
    rg --line-buffered "Event 'change' on (.+)" |
    while read -r _; do
        get_audio_outputs
    done
}

function get_active_sink {
    local sink_name
    sink_name=$(pactl get-default-sink)
    pactl list sinks | rg -oU "Sink #(\d+)\n.*\n.*Name: $sink_name\n.*Description: (.+)\n" -r '{"name": "$2", "id": $1}'
}

function follow_active_sink {
    get_active_sink
    pactl subscribe |
    rg --line-buffered "Event 'change' on (.+)" |
    while read -r _; do
        get_active_sink
    done
}

function set_active_sink {
    local sink_id
    local sink_name
    sink_id="$1"
    if [ "$sink_id" == "" ]; then
        echo "Enter a sink name."
        exit 1
    else
        pactl set-default-sink $sink_id
    fi
}

case "$1" in
    "set-volume") set_volume "$2";;
    "get-volume") get_volume;;
    "get-muted") get_muted;;
    "toggle-muted") toggle_muted;;
    "get-audio-outputs") get_audio_outputs;;
    "get-active-sink") get_active_sink;;
    "set-active-sink") set_active_sink "$2";;
    "follow-volume") follow_volume;;
    "follow-muted") follow_muted;;
    "follow-audio-outputs") follow_audio_outputs;;
    "follow-active-sink") follow_active_sink;;
    *) echo "Invalid command." && exit 1;;
esac
