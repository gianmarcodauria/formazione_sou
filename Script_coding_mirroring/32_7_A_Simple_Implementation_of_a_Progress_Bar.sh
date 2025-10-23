#! /bin/bash

interval=1 #setto variabile intervallo
long_interval=10 #setto variabile 
 
{ # le parentesi graffe racchiudonon un gruppo di comandi
     trap "exit" SIGUSR1 #trap definisce un comando da eseguire quando la shell riceve quel segnale,
     # 
     sleep $interval; sleep $interval # mette in pausa il processo per un tot pari al valore di interval
     while true
     do
       echo -n '.'     # Use dots.
       sleep $interval
     done; } &         # la & manda tutto in background
 
pid=$! #salva nella variabile pid l'ultimo processo eseguito in background ($!)
trap "echo !; kill -USR1 $pid; wait $pid"  EXIT        #  Al termine dello script 
#stampa ! uccide il processo user al $pid, attende il processo in background prima di chiudere lo script
 
echo -n 'Long-running process ' #stampa su un'unica linea, questo sarà la prima cosa che stampa il programma
# dal momento che il codice di prima è in background
sleep $long_interval #attende per il valore impostato in long_interval
echo ' Finished!'
 
kill -USR1 $pid #ucide il processo in back
wait $pid              # ferma il processo in attesa che muoia
trap EXIT.  
 
exit $? #esce con l'ultimo status 