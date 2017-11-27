#!/bin/bash
nohup java -Xms4096m -Xmx4096m -Xbootclasspath/a:conf -jar /ultrapower/smartlog/smartlog-api/smartlog-api-2.0.2-SNAPSHOT.jar > /ultrapower/smartlog/smartlog-api.log &
