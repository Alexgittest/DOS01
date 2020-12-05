#!/bin/bash

for var in `df -h | grep -e /dev/sd | awk '{printf "%d:%s:%s\n", $5,$1,$6}'`
do
disk_usage=`echo $var | cut -d ':' -f1`
disk_name=`echo $var | cut -d ':' -f2`
disk_mount=`echo $var | cut -d ':' -f3`
disk_mount=${disk_mount#/}

if [[ $disk_mount != "boot" ]] 
 then
  if (($disk_usage>70 && $disk_usage<80))
   then
    echo "WARNING - $disk_name DISK USAGE MORE THEN 70%" | mail -s "DISK USAGE" alex_king87@mail.ru
   elif (($disk_usage>80 && $disk_usage<90 ))
    then
     top10=`find . / -type f -exec du {} 2>/dev/null \;|sort -nr | head`
     echo "WARNING - $disk_name DISK USAGE MORE THEN 80%. TOP 10 FILES WITH BIG SIZE - $top10"
   elif (( $disk_usage>90 ))
    then
      for i in `find /var/log -type f -exec du {} 2>/dev/null \;|sort -nr | head -n 2 | cut -f2`
       do 
        echo "DELETING "$i
        rm -rf $i
       done
  else
    echo $disk_name" ALL IS OK"
 fi
fi
done
