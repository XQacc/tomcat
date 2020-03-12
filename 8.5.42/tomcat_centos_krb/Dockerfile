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
        fontconfig \
	kde-l10n-Chinese \
	glibc-common \
	cronie \
	crontabs
RUN sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
RUN yum clean all

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

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

#regular clear logs
RUN crond
ADD regular.sh /usr/local/tomcat/
RUN chmod +x /usr/local/tomcat/regular.sh
RUN echo "59     23       *       *       *       sh /usr/local/tomcat/regular.sh">>/var/spool/cron/root

RUN useradd paas
RUN mkdir -p /opt/data
RUN chown -R paas:paas /usr/local/tomcat
RUN chown -R paas:paas /opt/data
RUN fc-cache --force

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD java.security /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-0.el7_6.x86_64/jre/lib/security/
ADD krb5.conf /etc/krb5.conf
#字体
RUN mkdir -p /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.el7_6.x86_64/jre/lib/fonts/fallback
ADD simsun.ttc /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.el7_6.x86_64/jre/lib/fonts/fallback/
ADD simsun.ttf /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.el7_6.x86_64/jre/lib/fonts/fallback/
RUN mkfontscale
RUN mkfontdir
ADD simsun.ttc /usr/share/fonts/
ADD simsun.ttf /usr/share/fonts/
RUN mkfontscale
RUN mkfontdir

COPY entrypoint.sh /bin/
ENV LC_ALL zh_CN.UTF-8
RUN chmod +x /bin/entrypoint.sh
WORKDIR /usr/local/tomcat/
EXPOSE 8080
ENTRYPOINT ["/bin/entrypoint.sh"] 

CMD su paas -c "/usr/local/tomcat/bin/catalina.sh run"
