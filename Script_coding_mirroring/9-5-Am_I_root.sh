#!/bin/bash
 
ROOT_UID=0   #Assegnamo 0 a questa variabile.
 
if [ "$UID" -eq "$ROOT_UID" ]  # Se lo user id è uguale al contenuto di ROOT_UID
then
  echo "You are root." #stampa questo
else
  echo "You are just an ordinary user (but mom loves you just the same)." #oppure questo
fi
 
exit 0
 
# -------------------------- #
 
ROOTUSER_NAME=root #salvo root nella variabile
 
username=`id -nu`              #salva lo username attualmente in uso
if [ "$username" = "$ROOTUSER_NAME" ] #controllo, se sono uguali
then
  echo "Rooty, toot, toot. You are root." #stampa questo
else
  echo "You are just a regular fella." #o questo
fi