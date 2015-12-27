#!/bin/bash
#!/bin/bash
row=`df -h |wc -l`
for i in `seq 2 $row`
do
        ava=`df -h |sed -n "$i"p|awk '{print $4}'`
        u_per=`df -h |sed -n "$i"p|sed -n "s/\%//"p|awk '{print $5}'`
        p_p=`df -h -P|sed -n "$i"p|awk '{print $6}'`
        if [ "$u_per" -gt "97"  ];then
                echo -n "$p_p CRITICAL $u_per% $ava  "
                sta[$i]=2
        elif [ "$u_per" -gt "95" ];then
                echo -n "$p_p WARNING! $u_per% $ava  "
                sta[$i]=1
        else
                echo -n "$p_p OK $u_per% $ava  "
                sta[$i]=0
        fi
done
n=0
for j in `seq 2 $row`
do
        if [ "${sta[$j]}" -gt $n  ];then
                n=${sta[$j]}
        fi
done
exit $n
