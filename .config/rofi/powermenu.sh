#!/bin/sh
# Very basic powermenu script for Rofi
# Run with: rofi -show pm -modes "pm:powermenu.sh"

if [ x"$@" = x"Lock" ]
then
    nohup slock >/dev/null 2>&1 &
    exit 0
fi
if [ x"$@" = x"Suspend" ]
then
    loginctl suspend
    exit 0
fi
if [ x"$@" = x"Shutdown" ]
then
    loginctl poweroff
    exit 0
fi
if [ x"$@" = x"Reboot" ]
then
    reboot
    exit 0
fi

echo "\0prompt\037Power menu\n"

echo "Lock"
echo "Suspend"
echo "Shutdown"
echo "Reboot"

