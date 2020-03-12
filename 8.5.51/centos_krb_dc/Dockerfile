FROM docker.io/centos:centos7.4.1708

MAINTAINER "xieqiu"

RUN yum -y install telnet \
	java-1.8.0-openjdk-devel.x86_64 \
        apr \
        apr-util \
        apr-devel \
        openssl \
        krb5-libs \
        krb5-workstation \
        gcc \
        fontconfig
RUN yum clean all



RUN mkdir -p /opt/data
RUN fc-cache --force

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD java.security /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64/jre/lib/security/
ADD krb5.conf /etc/krb5.conf

COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
WORKDIR /root
ENTRYPOINT ["/bin/entrypoint.sh"] 

CMD "/bin/bash"
