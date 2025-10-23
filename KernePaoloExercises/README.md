PER DEBIAN:

- apt-get -s upgrade simula un aggiornamento dei pacchetti senza installare nulla (-s sta per simulate).

- 2>/dev/null reindirizza eventuali errori a /dev/null, quindi non li vediamo (con &1 reindirezzeremmo invece in standard input * vedi MACOS sotto).
- grep '^Inst' prende solo le righe che indicano pacchetti che verrebbero installati/aggiornati.
- grep 'linux-image' filtra i pacchetti legati al kernel.
- L’output viene salvato nella variabile are_there_updates. -z è un controllo che verifica che la variabile non sia vuota.
--------------------------------------------------------

PER MACOS:

* in questa circostanza, il ragionamento che ho applicato è il medesimo ma la differenza risiede nel fatto che in macOS l'aggiornamento del kernel è legato a quello del sistema operativo. In linux, invece, è possibile aggiornare il kernel indipendentemente dall'OS 

-  "my_updates=$(softwareupdate -l 2>&1) " questa linea di codice è interessante: il 2>&1 mi permette di reindirizzare lo standard error del comando software update sullo standard input, e lo salvo così in my_updates.

- [ if echo "$my_updates" | grep -q "No new software available." ] questa linea printa il contenuto di my_update e passa l'output a grep,che lo riceve come input e cercherà "no new software nel risultato ricevuto. -q permette di non stampare a schermo. A questo punto, grep avrà registrato uno status 0 o 1 se non è andato in porto.

- in base allo status registrato, il programma stamperà vero o falso

