FROM docker.io/centos:centos7.4.1708 

RUN mkdir -p /usr/local/software/
ADD libpcap-1.5.3-9.el7.x86_64.rpm /usr/local/software/
ADD net-tools.rpm /usr/local/software/
ADD tcpdump-4.5.1-2.el7.x86_64.rpm /usr/local/software/
ADD telnet-0.17-47.el6.x86_64.rpm /usr/local/software/
ADD redis-cli /usr/local/bin/
ADD start.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/start.sh
RUN rpm -ivh /usr/local/software/libpcap-1.5.3-9.el7.x86_64.rpm
RUN rpm -ivh /usr/local/software/net-tools.rpm
RUN rpm -ivh /usr/local/software/tcpdump-4.5.1-2.el7.x86_64.rpm
RUN rpm -ivh /usr/local/software/telnet-0.17-47.el6.x86_64.rpm
ENV FLAG RUNNING

RUN rm -rf /usr/local/software/*
CMD /bin/bash /usr/local/bin/start.sh
