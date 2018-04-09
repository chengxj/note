#!/bin/bash
# Author:chengxj
# smartlog-api启动脚本

#JDK所在路径
export JAVA_HOME=$JAVA_HOME
if [ -n $JAVA_HOME ];then
    JAVA_HOME=$JAVA_HOME
else
    JAVA_HOME="/ultrapower/smartlog/jdk1.8.0_101"
fi
echo "JAVA_HOME=" $JAVA_HOME
#获取系统默认JAVA_HOME

#执行程序启动所使用的系统账户
RUNNING_USER=root
#echo $(cd `dirname $0`; pwd)
APP_HOME=$(cd `dirname $0`; pwd)

# JAVA进程入口类
APP_MAINCLASS=com.ultrapower.zq.smartlog.api.SmartlogApi
# 依赖包 /conf /lib/*.jar
CLASS_PATH=$APP_HOME/../conf:$APP_HOME/../lib/*
#for i in $APP_HOME/../lib/*.jar; do
#    CLASS_PATH="$CLASS_PATH":"$i"
#done

JAVA_OPTS="-Xms2048m -Xmx2048m -XX:PermSize=512M -XX:MaxPermSize=2048m"

#进程ID
psid=0

# 获取进程ID
checkpid() {
    javajps=`$JAVA_HOME/bin/jps -l |grep $APP_MAINCLASS`
    if [ -n "$javajps" ]; then
        psid=`echo $javajps |awk '{print $1}'`
    else
        psid=0
    fi
}

#启动进程
start() {
    checkpid
    if [ $psid -ne 0 ]; then
        echo "====================================="
        echo "warn: $APP_MAINCLASS already started! (pid=$psid)"
        echo "====================================="
    else
        echo -n "Starting $APP_MAINCLASS ..."
        nohup $JAVA_HOME/bin/java $JAVA_OPTS -cp $CLASS_PATH $APP_MAINCLASS >/dev/null 2>&1 &
	    #su - $RUNNING_USER -c "$JAVA_CMD"
        checkpid
        if [ $psid -ne 0 ]; then
            echo "(pid=$psid) [OK]"
        else
            echo "[Failed]"
        fi
    fi
}

#停止进程
stop() {
    checkpid
    if [ $psid -ne 0 ];then
        echo -n "Stopping $APP_MAINCLASS ... (pid=$psid) "
        su - $RUNNING_USER -c "kill -9 $psid"
        if [ $? -eq 0 ];then
            echo "[OK]"
        else
            echo "[Failed]"
        fi

        checkpid
        if [ $psid -ne 0 ];then
            stop
        fi
    else
        echo "====================================="
        echo "warn: $APP_MAINCLASS is not running"
        echo "====================================="
    fi
}

#进程状态
status() {
    checkpid

    if [ $psid -ne 0 ];then
        echo "$APP_MAINCLASS is running! (pid=$psid)"
    else
        echo "$APP_MAINCLASS is not running"
    fi
}

# 信息
info() {
    echo "System Information:"
    echo "******************************"
    echo `head -n l /etc/issue`
    echo `uname -a`
    echo
    echo "JAVA_HOME=$JAVA_HOME"
    echo `$JAVA_HOME/bin/java -version`
    echo
    echo "APP_HOME=$APP_HOME"
    echo "APP_MAINCLASS=$APP_MAINCLASS"
    echo "*******************************"
}

case "$1" in
    'start')
      start
      ;;
    'stop')
      stop
      ;;
    'restart')
      stop
      start
      ;;
    'status')
      status
      ;;
    'info')
      info
      ;;
    *)
      echo "Usage"
      exit 1
esac
exit 0

