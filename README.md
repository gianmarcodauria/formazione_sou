PER DEBIAN:

- Faccio  echo che stamperà a schermo, dando inizio allo script, chiedendo se il kernel è aggiornato
- In my_kernel_version salvo la mia versione del kernel, che ottengo dall'esecuzione del comando uname r
- Lo stesso accade per la variabile successiva, latest_kernel_version, che salva il risultato del comando apt-cache policy linux-image-generic, il quale mi fornisce come risultato una serie di stringhe dalle quali andrò a selezionare Candidate, a cui segue il numero della versione dell'aggiornamento. Awk stampa il secondo campo
- In seguito, formatto e aggiorno le mie due variabili salvando in esse solo il numero della versione (con cut -d passo il delimitatore '-' e seleziono solo il campo prima del delimitatore, quindi i numeri, ed è utile per la lettura). Lo faccio per entrambe le variabili.
- Per ultimo, confronto le stringhe e capisco se il kernel è aggiornato oppure no.

--------------------------------------------------------

PER MACOS

* in questa circostanza, il ragionamento che ho applicato è il medesimo ma la differenza risiede nel fatto che in macOS l'aggiornamento del kernel è legato a quello del sistema operativo. In linux, invece, è possibile aggiornare il kernel indipendentemente dall'OS 

-  "my_updates=$(softwareupdate -l 2>&1) " questa linea di codice è interessante: il 2>&1 mi permette di reindirizzare lo standard error del comando software update sullo standard input, e lo salvo così in my_updates.

- [ if echo "$my_updates" | grep -q "No new software available." ] questa linea printa il contenuto di my_update e passa l'output a grep,che lo riceve come input e cercherà "no new software nel risultato ricevuto. -q permette di non stampare a schermo. A questo punto, grep avrà registrato uno status 0 o 1 se non è andato in porto.

- in base allo status registrato, il programma stamperà vero o falso

