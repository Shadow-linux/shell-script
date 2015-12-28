#!/bin/bash
for ((i=1;i<=9;i++))
do
    for ((j=1;j<=i;j++))
    do
        product=$[ $i * $j ]
        echo -ne $j*$i=$product"\t“
    done
    echo
    echo -e "\r"
done
 exit 0
