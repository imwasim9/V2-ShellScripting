#!/bin/bash

# color codes
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "$G Hello World $N"
echo -e "$R Hello World $N"
echo -e "$Y Hello World $N"
echo "Check this color"


# getting the user id id -u, sudo id -u
USER_ID=$(id -u) # running the command using $()

if [ $USER_ID -ne 0 ]; then
   echo -e "$R ERROR$N:: Please run this script with root privelege"
   exit 1 # failure code is 1 and success code is 0 for exit status
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
   echo -e "$R ERROR$N:: Installing MySQL failed please check logs"
   exit 1
else 
   echo -e "MySQL installation is $G successful $N"
fi

VALIDATE() {  #functions will recieve input via cmd line arguments just like shell script args
   if [ $1 -ne 0 ]; then
       echo -e "$R ERROR$N:: Installing $2 failed please check logs"
       exit 1 
   else 
       echo -e "$2 installation is $G successful$N"
   fi 
}

dnf list installed mysql
# Install only if it is not installed earlier
if [ $? -ne 0 ]; then
   dnf install mysql -y
   VALIDATE $? "MySql"
else
   echo -e "MySql is already installed .... $Y SKIPPING $N"
fi

dnf list installed nginx
if [ $? -ne 0 ]; then
   dnf install nginx -y
   VALIDATE $? "Nginx"
else 
   echo -e "Nginx is already installed .... $Y SKIPPING $N"
fi

dnf list installed python3
if [ $? -ne 0 ]; then
   dnf install python3 -y
   VALIDATE $? "Python3"
else 
  echo -e "Python3 is already installed .... $Y SKIPPING $N"
fi
   
