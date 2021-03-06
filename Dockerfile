# FROM openjdk:8
FROM openjdk:8-alpine
MAINTAINER  jay.pan@infinitus-int.com

ENV ZK_ADDRESSES=127.0.0.1:2181  ES_CLUSTER_NAME=elasticsearch ES_ADDRESSES=localhost:9300 BIND_HOST=localhost \
 NAMING_BIND_HOST=localhost NAMING_BIND_PORT=10800 REMOTE_BIND_HOST=localhost REMOTE_BIND_PORT=11800  \
 AGENT_GRPC_BIND_HOST=localhost  AGENT_GRPC_BIND_PORT=11800  AGENT_JETTY_BIND_HOST=localhost  AGENT_JETTY_BIND_PORT=12800  \
 UI_JETTY_BIND_HOST=localhost UI_JETTY_BIND_PORT=12800  

# RUN apk add --update \
#     supervisor \
#   && cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime \
#   && rm -rf /var/cache/apk/* \

# WORKDIR ${SKYWLK_HOME}
WORKDIR /usr/local/skywalking-collector
COPY collector-libs collector-libs
COPY config config
COPY bin bin

ADD docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh && chmod 755 -R bin

EXPOSE 10800 11800 12800 

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/collectorService.sh"]

#CMD ["bin/startup.sh"]