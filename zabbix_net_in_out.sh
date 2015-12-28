#!/bin/bash

##监控网卡每秒的流量
##Usage : ./eth.sh  eth[0-9]  in/out
##请手动在该机器运行一次需要监控的网卡in/out,让网卡生成一次临时文件

if [ $2 == "in" ]
then
  [ -f /tmp/net_date_$1_in.log ] || date +%s >> /tmp/net_date_$1_in.log
  [ -f /tmp/net_$1_in.log ] ||  grep $1 /proc/net/dev|awk '{print $2}' >> /tmp/net_$1_in.log
   d_old=`tail -1 /tmp/net_date_$1_in.log`
   d_new=`date +%s`
   net_old=`tail -1 /tmp/net_$1_in.log`
   net_new=`grep $1 /proc/net/dev|awk '{print $2}'`
   b=$[ $net_new - $net_old ]
   a=$[ $d_new - $d_old ]
   c=$[ $b / $a ]
   echo $c
   echo $d_new >> /tmp/net_date_$1_in.log
   echo $net_new >> /tmp/net_$1_in.log
   /bin/chown zabbix /tmp/net_date_$1_in.log
   /bin/chown zabbix /tmp/net_$1_in.log
elif [ $2 == "out" ]
then
   [ -f /tmp/net_date_$1_out.log ] || date +%s >> /tmp/net_date_$1_out.log
   [ -f /tmp/net_$1_out.log ] || grep $1 /proc/net/dev|awk '{print $10}' >> /tmp/net_$1_out.log
    d_old=`tail -1 /tmp/net_date_$1_out.log`
   d_new=`date +%s`
   net_old=`tail -1 /tmp/net_$1_out.log`
   net_new=`grep $1 /proc/net/dev|awk '{print $10}'`
   b=$[ $net_new - $net_old ]
   a=$[ $d_new - $d_old ]
   c=$[ $b / $a ]
   echo $c
   echo $d_new >> /tmp/net_date_$1_out.log
   echo $net_new >> /tmp/net_$1_out.log
   /bin/chown zabbix /tmp/net_date_$1_out.log
   /bin/chown zabbix /tmp/net_$1_out.log
else
    echo 0
fi
