#!/bin/sh
temp=$(curl --silent "wttr.in/${WEATHER_CITY}?format=%t" | cut -c1-6 | sed 's/+//g')
precipitation=$(curl --silent "wttr.in/${WEATHER_CITY}?format=%p" | cut -c1-6)
echo $temp
