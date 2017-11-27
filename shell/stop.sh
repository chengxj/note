#!/bin/bash

echo "----------stop smartlog-api process------------"
ID=`ps -ef|grep smartlog-api|grep -v grep |awk '{print $2}'`
echo $ID
echo "current process id = " $$
for id in $ID;do
 kill -9 $id
 echo "killed $id"
done
echo "-----------------------------------------------"
