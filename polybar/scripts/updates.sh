#!/bin/sh

updatesarch="$(checkupdates 2> /dev/null | wc -l)"
updatesaur="$(yay -Qum 2> /dev/null | wc -l)"
updates=$(("$updatesarch" + "$updatesaur"))

if [ "$updates" -eq 0 ]; then
    echo "0"
else
    echo -e " $updates"
fi
