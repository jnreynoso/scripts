#!/bin/bash

who | cat -n > /tmp/sessions

numses=`wc -l /tmp/sessions | awk '{print $1}'`

for i in $(seq 2 1 $numses)
do
    seccionactive=`sed -n "$i"p /tmp/sessions | awk '{print $3}'`
    echo Mensaje >> /dev/$seccionactive
done

rm /tmp/sessions
