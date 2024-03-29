#!/bin/sh

# this script is for launching the eww daemon and setting initial variable values which might require the output of a command or script.
# restart the eww daemon if necessary
if [ $(eww ping) == "pong" ]; then
    eww kill
fi
eww daemon &
# set initial variable values
eww update user=$USER hostname=$(hostname)
