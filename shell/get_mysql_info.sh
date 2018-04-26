#!/bin/bash
# author:chengxj
# time:2018/04/13

mysql << EOF
show master status \G
exit
EOF
