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

ctr="(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])"     
if [[ $host =~ ^$ctr\.$ctr\.$ctr\.$ctr$ ]]; then      #ciclo per stabilire se l'indirizzo hostv4 è valido
     echo "Indirizzo hostv4 valido:     "$host
  
else
      echo "Indirizzo hostv4 non valido! "$host
      exit 1
fi

a=$(echo "$host" | cut -d'.' -f1)     #prendiamo una variabile che prende il primo ottetto, dell'indirizzo inserito in input.


if echo "$a" | grep -Eq "^(12[0-7]|1[01][0-9]|[1-9]?[0-9])$"; then   #tramite la variabile facciamo un if e i conseguenti elif, per stabilire la classe di appartenenza del hostv4.
    echo " è un indirizzo di classe A"

elif echo "$a" | grep -Eq "^(12[89]|1[3-8][0-9]|19[01])$"; then
    echo " è un indirizzo di classe B"

elif echo "$a" | grep -Eq "^19[2-9]|2[01][0-9]|22[0-3]$"; then
    echo " è un indirizzo di classe C"

elif echo "$a" | grep -Eq "^22[4-9]|23[0-9]$"; then
    echo " è un indirizzo di classe D"

elif echo "$a" | grep -Eq "^24[0-9]|25[0-5]$"; then
    echo " è un indirizzo di classe E"

fi

if (( start < 1 || start > 65535 || end < 1 || end > 65535 || start > end )); then
    echo "Error: invalid range. It should be between 1-65535." >&2
    exit 1
fi

for ((i=start; i<=end; i++)); do
    if nc -n -w 1 "$host" "$i" </dev/null >/dev/null 2>&1; then
        echo "$i is open"
    fi
done

