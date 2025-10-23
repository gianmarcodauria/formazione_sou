#!/bin/bash
 
declare -A address #Ho corretto la flag -A in -a poiché il terminale mi diceva che era un'opzione invalida
# con declare -a address io dichiaro un array associativo chiamato address
 
# address è una mappa a struttura chiave/valore -> le chiavi sono i nomi tra parentesi quadre
# i valori il contenuto assegnato dall'uguale
address[Charles]="414 W. 10th Ave., Baltimore, MD 21236" 
address[John]="202 E. 3rd St., New York, NY 10009"
address[Wilma]="1854 Vermont Ave, Los Angeles, CA 90023"
 
 
echo "Charles's address is ${address[Charles]}." # Non ho ben capito cosa accade con questi 3 echo
# perché io pensavo andasse a stampare il singolo indirizzo diversificato per chiave ma effettivamente scritto così 
# il codice si limita ad aggiornare il valore di address con "1854 Vermont Ave, Los Angeles, CA 90023",
# stampandolo quind 3 volte 
# a quanto ho capito dovrebbe funzioanre con bash 4, ma io non ce l'ho installato
# se metto bash normale non ho errori ma l'array associativo sembra non funzionare
echo "Wilma's address is ${address[Wilma]}." 
echo "John's address is ${address[John]}."
 
echo
 
echo "${!address[*]}"  # stampa tutte le chiavi (non funziona)
# se fosse "${address[*]}" stamperebbe tutti i valori

