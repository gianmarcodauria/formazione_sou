#!/bin/bash

cd /var/log #questa riga cambia la directory corrente in /var/log
cat /dev/null > messages #svuota i messaggi con /dev/null, che è una sorta di "buco nero" 
cat /dev/null > wtmp #svuota il file wtmp, che registra i login e i logout
echo "Log files cleaned up." #stampa a schermo 