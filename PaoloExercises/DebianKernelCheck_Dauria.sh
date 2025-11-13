#!/bin/bash

echo "Is the kernel updated?"

my_kernel=$(uname -r)
are_there_updates=$(apt-get -s upgrade 2>/dev/null | grep '^Inst' | grep 'linux-image')

if [ -z "$are_there_updates" ]; then
    echo "true"
else
    echo "false"
fi