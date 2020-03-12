#!/bin/sh
cd /usr/local/tomcat/logs
mv catalina_${HOST}.out catalina_${HOST}_`date +%Y-%m-%d`.log
touch catalina_${HOST}.out
find  -mtime +3 -name "catalina_${HOST}_2*.log" | xargs rm -f
cd -
