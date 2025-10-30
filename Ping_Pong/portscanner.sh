#!/bin/bash

host="$1"
range="$2"

start="${range%%-*}"
end="${range#*-}"

door=()
i=0

for ((i=start; i<=end; i++)); do
    if nc -n -w 1; then
        door+=("$i")
        echo ("$i is open")
    fi
done

if (( ${#door[@]} )); then
    echo "these doors are open ${doors[@]}"
fi