#!/bin/bash
while :
do
flow(){
grep eth  /proc/net/dev |awk '{print $1}'|awk -F : '{print $2}'|sed -n '1'p >> /tmp/eth0_re.log
grep eth  /proc/net/dev |awk '{print $9}'|sed -n '1'p >> /tmp/eth0_tr.log
grep eth  /proc/net/dev |awk '{print $1}'|awk -F : '{print $2}'|sed -n '2'p >> /tmp/eth1_re.log
grep eth  /proc/net/dev |awk '{print $9}'|sed -n '2'p >> /tmp/eth1_tr.log
}
flow
eth0_re1=`tail -1 /tmp/eth0_re.log`
eth0_tr1=`tail -1 /tmp/eth0_tr.log`
eth1_re1=`tail -1 /tmp/eth1_re.log`
eth1_tr1=`tail -1 /tmp/eth1_tr.log`
sleep 1
flow
eth0_re2=`tail -1 /tmp/eth0_re.log`
eth0_tr2=`tail -1 /tmp/eth0_tr.log`
eth1_re2=`tail -1 /tmp/eth1_re.log`
eth1_tr2=`tail -1 /tmp/eth1_tr.log`
 
eth0_re=$[ $eth0_re2 - $eth0_re1 ]
eth0_tr=$[ $eth0_tr2 - $eth0_tr1 ]
eth1_tr=$[ $eth1_re2 - $eth1_re1 ]
eth1_re=$[ $eth1_tr2 - $eth1_tr1 ]
 
eth0_re_s=$[ $eth0_re / 1024 ]
eth0_tr_s=$[ $eth0_tr / 1024 ]
eth1_re_s=$[ $eth1_re / 1024 ]
eth1_tr_s=$[ $eth1_tr / 1024 ]
 
clear
echo "eth0 receive  : $eth0_re_s KB/s"
echo "eth0 transimt : $eth0_tr_s KB/s"
echo "eth1 receive  : $eth1_re_s KB/s"
echo "eth1 transmit : $eth1_tr_s KB/s"
 
for i in `ls /tmp/eth*`
do
  > $i
done
done
