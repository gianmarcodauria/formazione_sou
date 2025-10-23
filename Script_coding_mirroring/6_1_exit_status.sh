#!/bin/bash
 
echo hello #stampa hello a schermo
echo $?    # $? stampa lo status dell'ultimo comando eseguito
 
lskdf      # proviamo allora con un comando errato
echo $?    # ci restituirà uno status diverso da 0, quindi di errore, 
#           in questo caso 127 per command not found
 
echo
 
exit 113   # pone 113 come status.
