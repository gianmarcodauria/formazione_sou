#!/bin/bash
 
echo #stampa linea vuota

a=879 #assegno degli interi alla variabile a
echo "The value of \"a\" is $a." # stampa il valore corrente di ->$a -> 879
 
let a=16+5 #esegue l'assegnazione, è come il do ma per le operazioni aritmetiche e logiche
echo "The value of \"a\" is now $a." #stampa a schermo il corrente valore di $a -> 21
 
echo #stampa linea vuota
 
echo -n "Values of \"a\" in the loop are: " #la flag -n printa tutto su una riga
for a in 7 8 9 11 
do #esegue comando 
  echo -n "$a " #stampa i numeri sulla stessa riga
done #chiude
 
echo
echo
 
echo -n "Enter \"a\" " 
read a #prende in input la variabile 
echo "The value of \"a\" is now $a."  #stampa la variabile riassegnata
 
echo
 
exit 0 #esce con status 0 se il programma si è concluso positivamente