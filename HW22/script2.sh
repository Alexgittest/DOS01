#!/bin/bash
IPNOTCORRECT=1
MASKNOTCORRECT=1
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
    echo "Неправилные числа в ip адресе"
    IPNOTCORRECT=1
   else
    IPNOTCORRECT=0
   fi
else 
 echo "Неправильно введен ip"
 IPNOTCORRECT=1
fi
}

checkMASK() {
NUM=`echo $MASK | awk -F "." '{print NF}'`
if (($NUM==4))
then
 NUM1=`echo $MASK | awk -F "." '{print $1}'`
 NUM2=`echo $MASK | awk -F "." '{print $2}'`
 NUM3=`echo $MASK | awk -F "." '{print $3}'`
 NUM4=`echo $MASK | awk -F "." '{print $4}'`

  if (( $NUM1 == 255 ))
   then
     if (( $NUM2 == 255 ))
      then
        if (( $NUM3== 255 ))
         then
          if (( $NUM4==0||$NUM4==128||$NUM4==192||$NUM4==224||$NUM4==240))
           then
            MASKNOTCORRECT=0
          else 
           MASKNOTCORRECT=1
           echo "Четвертый октет не правильно"
           fi
         else 
          MASKNOTCORRECT=1
          echo "Третий октет не правильно"
         fi
      else
       MASKNOTCORRECT=1
       echo "Второй октет не правильно"
      fi
   else
    MASKNOTCORRECT=1
    echo "Первый октет не правильно"
   fi
else 
 echo "Неправильно введена маска"
 MASKNOTCORRECT=1
fi
}

checkIPRANGE() {
case $NUM4 in
           0 ) NUM4_START=1;NUM4_END=254;;
           128 ) 
                case 1 in
                    $(($IPNUM4>=0 && $IPNUM4<=127)) ) NUM4_START=1;NUM4_END=126;;
                    $(($IPNUM4>=128 && $IPNUM4<=255)) )NUM4_START=129;NUM4_END=254;;
                   esac;;
           192 )
                case 1 in
                    $(($IPNUM4>=0 && $IPNUM4<=63)) ) NUM4_START=1;NUM4_END=62;;
                    $(($IPNUM4>=64 && $IPNUM4<=127)) ) NUM4_START=65;NUM4_END=126;;
                    $(($IPNUM4>=128 && $IPNUM4<=191)) ) NUM4_START=129;NUM4_END=190;;
                    $(($IPNUM4>=192 && $IPNUM4<=255)) ) NUM4_START=193;NUM4_END=254;;
                   esac;;
           224)
                case 1 in
                    $(($IPNUM4>=0 && $IPNUM4<=31)) ) NUM4_START=1;NUM4_END=30;;
                    $(($IPNUM4>=32 && $IPNUM4<=63)) )NUM4_START=33;NUM4_END=62;;
                    $(($IPNUM4>=64 && $IPNUM4<=95)) )NUM4_START=65;NUM4_END=94;;
                    $(($IPNUM4>=96 && $IPNUM4<=127)) )NUM4_START=97;NUM4_END=126;;
                    $(($IPNUM4>=128 && $IPNUM4<=159)) ) NUM4_START=129;NUM4_END=158;;
                    $(($IPNUM4>=160 && $IPNUM4<=191)) ) NUM4_START=161;NUM4_END=190;;
                    $(($IPNUM4>=192 && $IPNUM4<=223)) ) NUM4_START=193;NUM4_END=222;;
                    $(($IPNUM4>=224 && $IPNUM4<=255)) ) NUM4_START=225;NUM4_END=254;;
                   esac;;
           240)
                   case 1 in
                    $(($IPNUM4>=0 && $IPNUM4<=15)) )NUM4_START=1;NUM4_END=14;;
                    $(($IPNUM4>=16 && $IPNUM4<=31)) )NUM4_START=17;NUM4_END=30;;
                    $(($IPNUM4>=32 && $IPNUM4<=47)) )NUM4_START=33;NUM4_END=46;;
                    $(($IPNUM4>=48 && $IPNUM4<=63)) )NUM4_START=49;NUM4_END=62;;
                    $(($IPNUM4>=64 && $IPNUM4<=79)) )NUM4_START=65;NUM4_END=78;;
                    $(($IPNUM4>=80 && $IPNUM4<=95)) )NUM4_START=81;NUM4_END=94;;
                    $(($IPNUM4>=96 && $IPNUM4<=111)))NUM4_START=97;NUM4_END=110;;
                    $(($IPNUM4>=112 && $IPNUM4<=127)))NUM4_START=113;NUM4_END=126;;
                    $(($IPNUM4>=128 && $IPNUM4<=143)))NUM4_START=129;NUM4_END=142;;
                    $(($IPNUM4>=144 && $IPNUM4<=159)))NUM4_START=145;NUM4_END=158;;
                    $(($IPNUM4>=160 && $IPNUM4<=175)))NUM4_START=161;NUM4_END=174;;
                    $(($IPNUM4>=176 && $IPNUM4<=191)))NUM4_START=177;NUM4_END=190;;
                    $(($IPNUM4>=192 && $IPNUM4<=207)))NUM4_START=193;NUM4_END=206;;
                    $(($IPNUM4>=208 && $IPNUM4<=223)))NUM4_START=209;NUM4_END=222;;
                    $(($IPNUM4>=224 && $IPNUM4<=239)))NUM4_START=225;NUM4_END=238;;
                    $(($IPNUM4>=240 && $IPNUM4<=255)))NUM4_START=241;NUM4_END=254;;
                   esac;;
        esac
}

while  (( $IPNOTCORRECT== 1 ))
do
echo "Введите ip адрес в формате  xxx.xxx.xxx.xxx "
read IP 
checkIP $IP
done

while  (( $MASKNOTCORRECT == 1 ))
do
echo "Введите маску подсети в формате 255.255.255.xxx"
read MASK
checkMASK $MASK
done

checkIPRANGE $IPNUM4 $NUM4

echo "SCAN start IP ---"$IPNUM1"."$IPNUM2"."$IPNUM3"."$NUM4_START
echo "Scan end IP----"$IPNUM1"."$IPNUM2"."$IPNUM3"."$NUM4_END

for (( i=$NUM4_START;$i<$NUM4_END;i=$i+1))
 do
 ping_result=`ping -c 3 $IPNUM1"."$IPNUM2"."$IPNUM3"."$i | grep received | cut -d , -f2 | cut -d ' ' -f2`
 if (( $ping_result == 3))
  then
   echo $IPNUM1"."$IPNUM2"."$IPNUM3"."$i"-----ping OK" 
   #scp -i /root/.ssh/id_rsa /root/service_for_hw22/* root@$IPNUM1"."$IPNUM2"."$IPNUM3"."$i:/etc/systemd/system
   #ssh -i /root/.ssh/id_rsa root@$IPNUM1"."$IPNUM2"."$IPNUM3"."$i 'systemctl start testservice.service' 
  else
   echo $IPNUM1"."$IPNUM2"."$IPNUM3"."$i"-----ping NOT OK"
fi
done
