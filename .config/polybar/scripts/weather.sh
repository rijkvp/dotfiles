#!/bin/sh
temp=$(curl --silent "wttr.in/${WEATHER_CITY}?format=%t" | cut -c1-6)
#ftemp=$(curl --silent "wttr.in/${WEATHER_CITY}?format=%f" | cut -c2-6)
precipitation=$(curl --silent "wttr.in/${WEATHER_CITY}?format=%p" | cut -c1-6)
echo $temp $precipitation
