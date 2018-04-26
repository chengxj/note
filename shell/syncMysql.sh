#!/bin/bash
mysql << EOF
GRANT ALL PRIVILEGES ON *.* TO 'replication'@'%' IDENTIFIED BY 'replication' WITH GRANT OPTION;
flush privileges;
grant replication slave on *.* to 'replication'@'%' identified by 'replication';
flush privileges;
GRANT FILE,SELECT,REPLICATION SLAVE ON *.* TO 'replication'@'%' IDENTIFIED BY 'replication';
flush privileges;
show master status \G
change master to master_host='10.0.0.111',master_user='replication',master_password='replication',master_log_file='mysql-bin.000001',master_log_pos=4514;
start slave;
show slave status\G
exit
EOF
