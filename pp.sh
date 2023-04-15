#!/bin/sh

current_governor=$(cpupower frequency-info --policy | grep -oP "The governor \"\K\w+")

if [ "$current_governor" == "performance" ]; then
    new_governor="powersave"
else
    new_governor="performance"
fi

echo "Switching from $current_governor to $new_governor"

sudo cpupower frequency-set --governor $new_governor

