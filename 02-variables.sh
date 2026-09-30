#!/bin/bash
# command line arguments
PERSON1=$1
PERSON2=$2
echo "$PERSON1 :: Hi $PERSON2, how are you?"
echo "$PERSON2 :: Hi $PERSON1, I am good and how are you?"

# read from command and use it in script
echo "$PERSON1 :: $PERSON2, what toy shall I bring you?" 
echo "$PERSON2 :: Dear $PERSON1, please get me the"
read -s TOYNAME
echo "$PERSON1 :: okay $PERSON2, I will get you $TOYNAME"
echo "$PERSON2 :: thanks my dear $PERSON1"
