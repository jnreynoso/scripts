#!/bin/bash

# General
cow=$(cowsay 'Alaaaaaaaaaaaaaa ... mrd')
marco="\e[1m\e[31m====================================================="
clearConsole='\0033\0143'
echo -e $clearConsole
echo -e $marco

# Elimina cache
if [ -f /tmp/facturactiva.data ]
then
    rm  /tmp/facturactiva.data
    echo -e "\e[1m\e[92mBase de Datos borrada!"
else
    echo -e "\e[1m\e[92mBase de datos no creada!"
fi

# Elimina los archivos XML Generados
cd $HOME/Coders/Facturactiva/Files/Enviados/
for line in $(find . -iname '*.xml'); do
    rm $line -f
done
cd $HOME/Coders/Facturactiva/Files/Recibidos-CDR/
for line in $(find . -iname '*.xml'); do
    rm $line -f
done
echo -e "\e[1m\e[92mArchivos XML borrados correctamente!"

# Mueve los archivos TXT a Pendientes
cd $HOME/Coders/Facturactiva/Files/
for F in `find "Pendientes/" -type f -name "*.txt"`; do
    echo -e "\e[1m\e[92mExisten ficheros en Pendientes!"
    echo "$cow"
    echo -e $marco
    exit
done
for line in $(find . -iname '*.txt'); do
    mv $line $HOME/Coders/Facturactiva/Files/Pendientes/ -f
done

cd $HOME/Coders/Facturactiva/generated-documents/
for line in $(find . -iname '*.xml' -o -iname '*.pdf'); do
    rm $line -f
done
rm -rf $HOME/Coders/Facturactiva/generated-documents/*
echo -e "\e[1m\e[92mReportes eliminados!"

#Final
echo -e "\e[1m\e[92mSe movieron Correctamente los archivos!"
echo "$cow"
echo -e $marco
