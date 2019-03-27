#!/bin/bash

for user in $(ls /home/)
do
echo $user
size=$(du -s /home/"$user" | cut -d "	" -f 1)
echo $size
if [ $size \> 32 ]
then
	echo Vous avez depassez votre quota > /home/$user/Attention.txt
fi
rec=$(cat /var/log/quota.txt | grep $user | tail -n 1 | cut -d ":" -f 2 | tr -d " ")
echo $rec
if [ -e /home/"$user"/Attention.txt ]
then
echo test
fi
echo $user : $size >> /var/log/quota.log
done
