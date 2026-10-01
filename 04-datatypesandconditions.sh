#!/bin/bash

NUMBER1=30
NUMBER2=40
NAME=wasim
SUM=$(($NUMBER1+$NUMBER2+$NAME))
echo "Total sum: $SUM"

NUMBER=$1

if [ $NUMBER -lt 10 ]; then
   echo "$NUMBER is less than 10
else
  echo "$NUMBER is greater or equal to 0
fi