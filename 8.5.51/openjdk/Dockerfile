FROM docker.io/openjdk:8-jdk-alpine 

RUN echo "#aliyun" > /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.8/main/" >> /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.8/community/" >> /etc/apk/repositories
RUN apk update
RUN apk --no-cache add ca-certificates curl
RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        su-exec \
        dumb-init \
        busybox-extras \
        tzdata \
        bash \
        fontconfig \
        font-adobe-100dpi \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo "Asia/Shanghai" > /etc/timezone \ 
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/* /var/tmp/*

RUN apk add --update ttf-dejavu
RUN fc-cache --force

RUN mkdir -p /app
RUN mkdir -p /opt/data
ADD arthas.tar /app/
ADD pinpoint.tar /app/

COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
ENTRYPOINT ["/bin/entrypoint.sh"]

CMD ["/bin/bash"]
