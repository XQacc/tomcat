#!/usr/bin/dumb-init /bin/sh

uid=${FLUENT_UID:-1000}

# check if a old fluent user exists and delete it
cat /etc/passwd | grep fluent
if [ $? -eq 0 ]; then
    deluser fluent
fi

# (re)add the fluent user with $FLUENT_UID
adduser -D -g '' -u ${uid} -h /home/fluent fluent

#source vars if file exists
DEFAULT=/etc/default/fluentd

if [ -r $DEFAULT ]; then
    set -o allexport
    source $DEFAULT
    set +o allexport
fi

#chown home and data folder
chown -R fluent:fluent /home/fluent
chown -R fluent:fluent /fluentd
chown -R fluent:fluent /usr/local/tomcat


if [ -z "$LOGPATH" ]
then
  echo "LOGPATH is not configure"
  exit 1
fi

if [ -z "$LOGPATH1" ]
then
  echo "LOGPATH1 is not configure"
  exit 1
fi

if [ -z "$BROKERS" ]
then
  echo "BROKERS is not configure"
  exit 1
fi

if [ -z "$KAFKA_TOPIC" ]
then
  echo "KAFKA_TOPIC is not configure"
  exit 1
fi
if [ -z "$KAFKA_TOPIC_OUT" ]
then
  echo "KAFKA_TOPIC_OUT is not configure"
  exit 1
fi

export REAL_LOGPATH="$(echo "$LOGPATH" | sed 's/\//\\\//g')"
export REAL_LOGPATH1="$(echo "$LOGPATH1" | sed 's/\//\\\//g')"

sed -i "s/{LOGPATH}/${REAL_LOGPATH}/g" /fluentd/etc/fluent.conf
sed -i "s/{BROKERS}/${BROKERS}/g" /fluentd/etc/fluent.conf
sed -i "s/{KAFKA_TOPIC}/${KAFKA_TOPIC}/g" /fluentd/etc/fluent.conf
sed -i "s/{TENANTID}/${TENANTID}/g" /fluentd/etc/fluent.conf
sed -i "s/{_SYS}/${_SYS}/g" /fluentd/etc/fluent.conf
sed -i "s/{_SAPP}/${_SAPP}/g" /fluentd/etc/fluent.conf
sed -i "s/{_SGRP}/${_SGRP}/g" /fluentd/etc/fluent.conf
sed -i "s/{_ITG}/${_ITG}/g" /fluentd/etc/fluent.conf
sed -i "s/{HOST}/${HOST}/g" /fluentd/etc/fluent.conf
sed -i "s/{LOGPATH1}/${REAL_LOGPATH1}/g" /fluentd/etc/fluent.conf
sed -i "s/{KAFKA_TOPIC_OUT}/${KAFKA_TOPIC_OUT}/g" /fluentd/etc/fluent.conf

exec su-exec fluent "$@"
