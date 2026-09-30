#!/bin/bash
# Running command inside the script and taking it to ouput. Please refer it's usage in line 29.
START_TIME=$(date +%s)

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

# environment variables use export VAR_NAME=value
echo "Wasim is learning $COURSE"
# environment variables in .bashrc export VAR_NAME=value will remain after the relogin and also takes preceding
echo "Wasim is learning currently $COURSE"

#Usage of date and time which will be useful in scripting
DATE=$(date)
echo "Today date is $DATE"

# sleep 10
END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME - $START_TIME))
echo "Time taken to execute the script is $TOTAL_TIME seconds"
echo "pid of the process: $$"
echo "Printing all variables passed to the script using @: $@"
echo "pid of the last command: $!"