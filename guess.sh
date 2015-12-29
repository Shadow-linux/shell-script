#!/bin/bash
##随机生成一个1-99的数字，用户每次猜数会减少猜数范围，直至猜中为止！

echo -e "\033[33m 猜数游戏即将开始，随机生成一个1-99的数字，enjoy yourself! \033[0m "
sleep 1
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



##定义一个输入数字范围函数
range_num(){
if [ $num -gt 100 ]
then
   echo -e "\033[33m 输入的数值超出范围，请输入1~100 \033[0m"
   continue
elif [  $num -lt 1 ]
then
   echo  -e  "\033[33m 输入的数值超出范围，请输入1~100 \033[0m"
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
    echo -e "\033[33m 你输入的不是一个数字，请重新输入 \033[0m"
    continue
fi
}
##定义a b 初始值
a=100
b=0
##初始化/tmp/[ab].log
echo 100 > /tmp/a.log
echo 1 > /tmp/b.log
##定义一个判断输入数值不能大于或小于上一次数值
range_cd(){
  c=`tail -1 /tmp/a.log`
  d=`tail -1 /tmp/b.log`
  if [ $num -gt $c ]
then
   echo -e "\033[33m 数值大于刚才输入的数值'$c' \033[0m "
   continue
  elif [ $num -lt $d ]
then
   echo -e "\033[33m 数值小于刚才输入的数值'$d' \033[0m"
   continue
  else
   echo -en "\t"
fi
}
##初始化sum
sum=0
##将1-9的数字，前面加0
numeric(){
for (( i=1;i<=9;i++))
do
if [ $num == $i ]
then
   num="0$num"
   break
fi
done
}


##定义一个随机数
   ran=`tr -dc 0-9 < /dev/urandom|head -c 2`
echo "$ran" > caishu.log
while :
do
read -p  " Input a number: " num
numeric
range_cd
judge
range_num
if [ $num == $ran ]
then
  echo -e "\033[32m  ok,you are right \033[0m "
  break
elif [ $num != $ran ]
then
   range_guess
   echo -e "\033[36m 很遗憾猜错了,范围是 $a~$b \033[0m"
   echo "$a" > /tmp/a.log
   echo "$b" > /tmp/b.log
   sum=$[ $sum + 1 ]
   echo -e "\033[31m error count:\033[0m \033[35m $sum \033[0m "
   continue
else
   exit 0
fi
done

if [ $sum -le 5 ]
then
 echo -e "\033[32m 实力和运气都是，棒棒的！\033[0m"
elif [ $sum -gt 5 -a $sum -lt 10 ]
then
  echo -e "\033[32m 不错不错！\033[0m"
else
   echo -e "\033[35m 你是猪吗？\033[0m"
fi
