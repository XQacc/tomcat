FROM docker.io/centos:centos7.4.1708

MAINTAINER "xieqiu"

RUN yum -y install telnet \
	java-1.8.0-openjdk-devel.x86_64 \
        apr \
        apr-util \
        apr-devel \
        openssl \
        gcc \
        fontconfig
RUN yum clean all


ADD tomcat.tar /usr/local/
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH
RUN tar -zxvf /usr/local/tomcat/bin/tomcat-native.tar.gz -C /usr/local/tomcat/bin/ \
    && cd /usr/local/tomcat/bin/tomcat-native-1.2.21-src/native/ \ 
    && ./configure --with-java-home=/usr/lib/jvm/java-1.8.0-openjdk \
    && make \
    && make install \
    && rm -rf /usr/local/tomcat/bin/tomcat-native.tar.gz \
    && rm -rf /usr/local/tomcat/bin/tomcat-native-1.2.21-src \ 
    && cp -rf /usr/local/apr/lib/* /usr/lib/

RUN useradd paas
RUN mkdir -p /opt/data
RUN chown -R paas:paas /usr/local/tomcat
RUN chown -R paas:paas /opt/data
RUN fc-cache --force

WORKDIR /usr/local/tomcat/
EXPOSE 8080
 

CMD su paas -c "/usr/local/tomcat/bin/catalina.sh run"
