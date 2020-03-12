#!/usr/bin/dumb-init /bin/bash

uid=${PAAS_UID:-1000}

# check if a old paas user exists and delete it
cat /etc/passwd | grep paas
if [ $? -eq 0 ]; then
    deluser paas
fi

# (re)add the paas
adduser -D -g '' -u ${uid} -h /home/paas paas

#chown home and data folder
chown -R paas:paas /app
chown -R paas:paas /opt/data




exec su-exec paas "$@"
