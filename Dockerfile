FROM alpine

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD=
ENV METHOD      aes-256-cfb
ENV PLUGIN      http_simple
ENV TIMEOUT     300
ENV DNS_ADDR    8.8.8.8
ENV DNS_ADDR_2  8.8.4.4


RUN apk add --update \
    python \
    libsodium \
    unzip \
    wget \
  && rm -rf /var/cache/apk/*



RUN wget --no-check-certificate https://github.com/breakwa11/shadowsocks/archive/manyuser.zip -O /tmp/manyuser.zip \
    && unzip -d /tmp /tmp/manyuser.zip \
    && mv /tmp/shadowsocks-manyuser/shadowsocks ~/shadowsocks \
    && rm -rf /tmp/*


WORKDIR ~/shadowsocks

RUN cp -n apiconfig.py userapiconfig.py \
    && cp -n config.json user-config.json \
    && cp -n mysql.json usermysql.json

CMD python server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD  -O auth_sha1_v4 -o http_simple

