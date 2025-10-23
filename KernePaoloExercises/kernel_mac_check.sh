#!/bin/bash

echo "Is the kernel updated?"

my_macos=$(sw_vers -productVersion)

my_updates=$(softwareupdate -l 2>&1)

if echo "$my_updates" | grep -q "No new software available."; then
    echo "true"
else
    echo "false"
fi
