#!/bin/bash
##随机生成一个1-100的数字，用户每次猜数会减少猜数范围，直至猜中为止！

##定义一个猜数范围函数
range_guess(){
 if [ $num -gt $ran ]
then
   a=$num
elif [ $num -lt $ran ]
then
 b=$num
else
  echo  "good" >/dev/null 2>&1

fi

}

##定义一个范围不能超出上次显示的范围
define_cd(){
   c=$a
   d=$b
}


##定义一个输入数字范围函数
range_num(){
if [ $num -gt 100 ]
then
   echo "输入的数值超出范围，请输入1~100"
   continue
elif [  $num -lt 1 ]
then
   echo "输入的数值超出范围，请输入1~100"
   continue
else
   echo  "good" >/dev/null 2>&1
fi
}

##定义一个判断是否为数字函数
judge(){
if_num=`echo $num |sed 's/[0-9]//g'`
if [ -z $if_num ]
then
   echo "good" >/dev/null 2>&1
else
    echo "你输入的不是一个数字，请重新输入"
    continue
fi
}
##定义a b 初始值
a=100
b=1
##初始化/tmp/[ab].log
echo 100 > /tmp/a.log
echo 1 > /tmp/b.log
##定义一个判断输入数值不能大于或小于上一次数值
range_cd(){
  c=`tail -1 /tmp/a.log`
  d=`tail -1 /tmp/b.log`
  if [ $num -gt $c ]
then
   echo "数值大于刚才输入的数值'$c'"
   continue
  elif [ $num -lt $d ]
then
   echo "数值小于刚才输入的数值'$d'"
   continue
  else
   echo -en "\t"
fi
}

##定义一个随机数
   ran=`tr -dc 0-9 < /dev/urandom|head -c 2`
   if [ $ran == "00" ]
then
   ran=100
fi
echo "$ran" > caishu.log
while :
do
read -p "input a number:" num
range_cd
judge
range_num
if [ $num == $ran ]
then
  echo "ok,you are right"
  break
elif [ $num != $ran ]
then
   range_guess
   echo "很遗憾猜错了,范围是 $a~$b"
   echo "$a" > /tmp/a.log
   echo "$b" > /tmp/b.log
   sum=$[ $sum + 1 ]
   echo "error count:$sum"
   continue
else
   exit 0
fi
done
