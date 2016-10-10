ETH=ens224
FILE_CPU=test_cpu.csv
FILE_MEM=test_mem.csv
FILE_NET=test_net.csv
: > $FILE_CPU
: > $FILE_MEM
: > $FILE_NET

sar -u 1 1 |sed -n 3p|sed -e 's/  */,/g'| sed "s/^/0,/g" >> $FILE_CPU
sar -n DEV 1 1 |sed -n 3p|sed -e 's/  */,/g'| sed "s/^/0,/g" >> $FILE_NET
sar -r 1 1| sed -n 3p|sed -e 's/  */,/g'| sed "s/^/0,/g" >> $FILE_MEM

for (( i = 0; i < 100; i++ )); do
    num=$i
    sar -u 1 1 |sed -n 4p|sed -e 's/  */,/g'| sed "s/^/$num,/g" >> $FILE_CPU & sar -n DEV 1 1|grep $ETH |head -n 1 |sed -e 's/  */,/g'| sed "s/^/$num,/g" >> $FILE_NET & sar -r 1 1| sed -n 4p|sed -e 's/  */,/g'| sed "s/^/$num,/g" >> $FILE_MEM
done
