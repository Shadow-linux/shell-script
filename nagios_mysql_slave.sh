#!/bin/bash
a=`/usr/local/mysql/bin/mysql -uroot -pa123456 -e "show slave status \G"|grep "Slave_IO_R"|awk -F ':' '{print $2}'|grep Yes|sed 's/ //'`
b=`/usr/local/mysql/bin/mysql -uroot -pa123456 -e "show slave status \G"|grep " Slave_SQL_R"|awk -F ':' '{print $2}'|grep Yes|sed 's/ //'`

if [[ "$a" == "Yes" &&  "$b" == "Yes" ]]
then
  echo  "OK - slave si running "
  exit 0
else
  echo  "CRITICAL - slave is error"
   exit 2
fi
