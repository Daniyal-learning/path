#!/bin/bash

em1='\xf0\x9f\xa7\x90\x0a\x00'
em2='\xf0\x9f\x98\x87\x0a\x00'
em3='\xf0\x9f\x98\x83\x0a\x00'
em4='\xf0\x9f\x98\x94\x0a\x00'
em5='\xf0\x9f\x98\xa1\x0a\x00'
em6='\xf0\x9f\x91\xbb\x0a\x00'

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}Make sure you are running this script in webroot(public_html)${NC} $em1"
echo "Provide Old Path:"
read oldpwd < /dev/tty

newpwd=$(pwd)

echo "Old path is $oldpwd"
echo "New path is $newpwd"


echo $'\nDid you create a backup?[yes/no]?'
read ANSWER  < /dev/tty

if [ -z "$ANSWER" ]; then
        echo -e "There is no answer. $em4"
        exit



fi

if [ "$ANSWER" = "yes" ]; then
        echo -e "Running Search and Replace $em2"

string1=$(echo $oldpwd | sed 's_/_\\/_g')
string2=$(echo $newpwd | sed 's_/_\\/_g')
find . -type f -exec sed -i "s/$string1/$string2/g" {} \;
wp search-replace "$oldpwd" "$newpwd" --all-tables --allow-root
echo -e "Search and replace completed! $em3 " 
exit

elif [ "$ANSWER" = "no" ]; then
        echo -e "Process terminated! $em5 "
        exit
else
        echo -e "Wrong Answer! Bye. $em6 "

fi
