ETH=ens224
FILE_CPU=test_cpu.csv
FILE_MEM=test_mem.csv
FILE_NET=test_net.csv
FILE_STREAM=test_stream.csv
: > $FILE_CPU
: > $FILE_MEM
: > $FILE_NET
: > $FILE_STREAM

sar -u 1 1 |sed -n 3p|sed -e 's/  */,/g'| sed "s/^/0,/g" >> $FILE_CPU
sar -n DEV 1 1 |sed -n 3p|sed -e 's/  */,/g'| sed "s/^/0,/g" >> $FILE_NET
sar -r 1 1| sed -n 3p|sed -e 's/  */,/g'| sed "s/^/0,/g" >> $FILE_MEM
echo "time,session" >> $FILE_STREAM


for (( i = 0; i < 1000; i++ )); do
    num=$i
    sar -u 1 1 |sed -n 4p|sed -e 's/  */,/g'| sed "s/^/$num,/g" >> $FILE_CPU & sar -n DEV 1 1|grep $ETH |head -n 1 |sed -e 's/  */,/g'| sed "s/^/$num,/g" >> $FILE_NET & sar -r 1 1| sed -n 4p|sed -e 's/  */,/g'| sed "s/^/$num,/g" >> $FILE_MEM
    curl -s -H "Content-Type: application/json" -X POST -d '{"janus":"list_sessions","transaction":"unko","admin_secret":"janusoverlord"}' http://localhost:7088/admin | jq ".sessions| length" | sed "s/^/$num,/g" >> $FILE_STREAM
done


