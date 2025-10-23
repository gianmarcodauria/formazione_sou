#!/bin/bash
 
# Questo script prende in input 10 argomenti
MINPARAMS=10 
 
echo
 
echo "The name of this script is \"$0\"." #Argomento 0 è il nome del programma, quindi dello script
echo "The name of this script is \"`basename $0`\"."  #basename non prende il . della directory
 
echo
 
if [ -n "$1" ]              # -n testa che la stringa alla posizione $1 non sia vuota.
then #se non lo à
 echo "Parameter #1 is $1"  #stampa il primo parametro
fi
 
if [ -n "$2" ] #stessa cosa con $2
then
 echo "Parameter #2 is $2"
fi
 
if [ -n "$3" ] #stessa cosa con $3
then
 echo "Parameter #3 is $3"
fi

 
 
if [ -n "${10}" ]  # Parametri sopra il 9 vanno scritti tra parentesi graffe
then
 echo "Parameter #10 is ${10}"
fi
 
echo "-----------------------------------"
echo "All the command-line parameters are: "$*"" #$* stampa tutti i valori degli argomenti dati
 
if [ $# -lt "$MINPARAMS" ] # $# indica il numero degli argomenti passati è less then valore della variabile $MINIPARAMS
then
  echo
  echo "This script needs at least $MINPARAMS command-line arguments!" # stampa la variabile
fi 
 
echo
 
exit 0