#!/bin/bash

if (( $# < 2 )); then
        echo "Error: not enough arguments." >&2
        exit 1
fi

host="$1"
range="$2"

start="${range%%-*}"
end="${range#*-}"

i=0

if (( start < 1 || start > 65535 || end < 1 || end > 65535 || start > end )); then
    echo "Error: invalid range. It should be between 1-65535." >&2
    exit 1
fi

for ((i=start; i<=end; i++)); do
    if nc -n -w 1 "$host" "$i" </dev/null >/dev/null 2>&1; then
        echo "$i is open"
    fi
done

