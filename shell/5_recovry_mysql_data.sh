#!/bin/bash
# author:chengxj
# time:2018/04/13

FILE_PATH=$1
#mkdir -p $FILE_PATH
cp -a $FILE_PATH /var/lib/mysql/*
echo 'mysql data recovry success!'
