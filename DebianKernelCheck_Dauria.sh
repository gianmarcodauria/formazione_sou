#!/bin/bash

echo "Is the kernel updated?"

my_kernel=$(uname -r)
latest_kernel_version=$(apt-cache policy linux-image-generic | grep Candidate | awk '{print $2}')

my_kernel=$(echo "$my_kernel" | cut -d'-' -f1)
latest_kernel_version=$(echo "$my_kernel" | cut -d'-' -f1)

if [ "$my_kernel" = "$latest_kernel_version" ]; then
    echo "true"
else
    echo "false"
fi