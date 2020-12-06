#!/bin/bash 

IPNOTCORRECT=1

checkIP() {
NUM=`echo $IP | awk -F "." '{print NF}'`
if (($NUM==4))
then
 IPNUM1=`echo $IP | awk -F "." '{print $1}'`
 IPNUM2=`echo $IP | awk -F "." '{print $2}'`
 IPNUM3=`echo $IP | awk -F "." '{print $3}'`
 IPNUM4=`echo $IP | awk -F "." '{print $4}'`
  if (( $IPNUM1<1 || $IPNUM1>223 )) || ((  $IPNUM2<0 || $IPNUM2>255 )) || ((  $IPNUM3<0 || $IPNUM3>255 )) || ((  $IPNUM4<0 || $IPNUM4>255 ))
   then
    IPNOTCORRECT=1
   else
    IPNOTCORRECT=0
    
   fi
else 
 IPNOTCORRECT=1
fi
}



while read LINE
do

 if  [[ ${LINE:0:1} = "#" ]]
  then
   continue
 fi

 IP=`echo $LINE | cut -d '#' -f1`

 checkIP $IP

 if (( $IPNOTCORRECT==0  ))
  then
    ping_result=`ping -c 5 -W 1 $IP | grep received | cut -d , -f2 | cut -d ' ' -f2`
    if (($ping_result == 5))
     then 
      echo "$IP HOST CHANGE STATUS FROM DOWN TO UP "
#      echo  "$IP HOST CHANGE STATUS FROM DOWN TO UP " | mail -s "HOST STATUS CHANGED" ermvs88ryv57@mail.ru
     else 
      echo "$IP HOST CHANGE STATUS FROM UP TO DOWN "
#      echo  "$IP HOST CHANGE STATUS FROM DOWN TO UP " | mail -s "HOST STATUS CHANGED" ermvs88ryv57@mail.ru
    fi
   else 
    echo $IP"--- не правильный ip адрес" 
 fi

done < ip_add_list
