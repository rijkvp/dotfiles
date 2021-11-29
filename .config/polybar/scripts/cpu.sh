#!/bin/sh
cpu_temp=$(sensors k10temp-pci-00c3| grep -A 0 'Tctl:' | cut -c16-19)
cpu_temp=$(printf '%.*f\n' 0 $cpu_temp)
cpu_load=$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]
echo "$cpu_load% $cpu_temp°C"
