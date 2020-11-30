#!/bin/bash

echo "Введите число строк для полсчета суммы и среднего значения"
read n
for (( i=1;$i<$n+1;i=$i+1 ))
 do
  echo "Введите 3 числа разделенные пробелом"
  read x y z
  let  sumx=${sumx}+${x}
  let  sumy=${sumy}+${y}
  let  sumz=${sumz}+${z}
done
echo "----Result----"
echo sum ${sumx} ${sumy} ${sumz}
echo avg $((${sumx}/$n)) $((${sumy}/$n)) $((${sumz}/$n))
