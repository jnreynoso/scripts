#!/bin/bash

# Globals
cow=$(cowsay 'Correcto!')
clearConsole='\0033\0143'
BLUE='\033[0;34m'
RED='\033[0;31m'
OTHER='\e[1;31m'
auth='user%password'

reset_console() {
    echo -e $BLUE
}

display_usage() {
    echo -e $BLUE
	  echo "Este es script es usado para conectarse a la red Wunderman" 
	  echo -e "\nUsage:\n$0 [arguments]"
	  echo -e "\n[arguments]"
	  echo -e "\n\t-l <folder>\t\t Muestra el contenido del directorio"
	  echo -e "\n\t-g <remote> <local>\t Obtiene Archivos o Directorios de la Red"
}

if [[ ( $# == "--help") ||  $# == "-h" ]] 
then
		display_usage
		exit 0
fi

if [[ $1 == "-l" ]]
then
    reset_console
    if [ -z $2 ]
    then
        smbclient "//10.12.10.110/publico/" -U $auth -c "cd Jean-Reynoso;ls"
    elif [ $2 == '-r']
    then
        smbclient "//10.12.10.110/publico/" -U $auth -c "cd Jean-Reynoso;recurse;ls"
    elif [ $2 == '-f']
    then
        smbclient "//10.12.10.110/publico/" -U $auth -c "cd Jean-Reynoso;recurse;ls" |grep -i $3
    else
        smbclient "//10.12.10.110/publico/" -U $auth -c "cd Jean-Reynoso;cd $2;ls"
    fi
elif [[ $1 == "-g" ]]
then
    if [ -z $3 ]
    then
        display_usage
        exit 0
    else
        reset_console
        smbclient "//10.12.10.110/publico/" -U $auth -c "cd Jean-Reynoso;cd $2;lcd $3;prompt OFF;recurse ON;mget *"
    fi
else
    display_usage
    exit 0
fi

echo -e "${RED}$cow"
