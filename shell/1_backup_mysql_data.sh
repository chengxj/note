#!/bin/bash
# author:chengxj
# time:2018/04/13

FILE_PATH=$1
mkdir -p $FILE_PATH
cp -a /var/lib/mysql/* $FILE_PATH
echo 'mysql data backup success!'
