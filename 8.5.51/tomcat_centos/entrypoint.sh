#!/bin/bash

#clean log
rm -rf /usr/local/tomcat/logs/*



exec "$@"
