#!/bin/bash

cat /etc/hosts | while read ip nume do
  if [["$ip" == \#* || -z "$ip"]];
then
   continue
 fi

rezult=(nslookup"nume"|awk '/^Name:/ {found=1; next} found && /^Address:/{print $2')


  if !echo "rezult"| grep-Fxq"ip"; then
       echo "Bogus Ip"
 fi
done 
