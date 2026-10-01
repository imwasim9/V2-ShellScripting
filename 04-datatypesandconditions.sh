#!/bin/bash

NUMBER1=30
NUMBER2=40
NAME=wasim
SUM=$(($NUMBER1+$NUMBER2+$NAME))
echo "Total sum: $SUM"

# gt or lt numbers
NUMBER1=$1

if [ $NUMBER1 -lt 10 ]; then
   echo "$NUMBER1 is less than 10"
else
  echo "$NUMBER1 is greater or equal to 0"
fi

# even or odd numbers
NUMBER2=$2
if [ $(($NUMBER2 %2)) -eq 0 ]; then
   echo "Given number $NUMBER2 is even"
else 
   echo "Given number $NUMBER2 is odd"
fi

