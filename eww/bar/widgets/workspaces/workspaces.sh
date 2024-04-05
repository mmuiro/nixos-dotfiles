function get_workspaces {
    MAX_WORKSPACES=10
    # initialize the empty workspace list
    workspace_list=()
    for id in $(seq 1 $MAX_WORKSPACES);
    do
        workspace_list+=("{\"id\": $id, \"windows\": 0}")
    done
    # repopulate the workspace list with the workspace info from hyprland and determine the highest id workspace
    max_id=1
    while read -r workspace_info;
    do
        id=$(echo $workspace_info | jq '.id')
        max_id=$(( id > max_id ? id : max_id ))
        workspace_list[$((id - 1))]=$workspace_info
    done <<< $(hyprctl workspaces | rg -o -U "workspace ID ([0-9]+).*\n.*\n.*windows: ([0-9]+)" -r '{"id": $1, "windows": $2}')
    jq --compact-output --null-input '$ARGS.positional' --args -- "${workspace_list[@]::$max_id}"
}

function get_active_workspace {
    out=$(hyprctl activeworkspace | rg -o "workspace ID ([0-9]+)" -r '$1')
    echo $out
}

function follow_workspaces {
    get_workspaces
    # also update the active workspace since eww doesn't want to work right :)
    eww update active_workspace="$(get_active_workspace)"
    socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line;
    do
        if [ "$(echo $line | rg "(workspace>>|openwindow>>)")" ];
        then
            get_workspaces
            eww update active_workspace="$(get_active_workspace)"
        fi
    done
}



function set_active_workspace {
    hyprctl dispatch workspace $1
}

case $1 in
    "get-workspaces") get_workspaces;;
    "follow-workspaces") follow_workspaces;;
    "set-active-workspace") set_active_workspace $2;;
    *) echo "Invalid command." && exit 1;
esac
