FROM java:8

ENV ES_PKG_NAME elasticsearch-2.1.0
ENV ES_CLUSTER_NAME es-cluster

RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

RUN useradd elasticsearch

ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN sed -i 's/elasticsearch-cluster/'"$ES_CLUSTER_NAME"'/g' /elasticsearch/config/elasticsearch.yml

WORKDIR /data

RUN chown -R elasticsearch:elasticsearch /data /elasticsearch

USER elasticsearch

EXPOSE 9200
EXPOSE 9300
EXPOSE 9300/udp
EXPOSE 54328
EXPOSE 54328/udp

RUN /elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/2.0/v2.1.1

CMD ["/elasticsearch/bin/elasticsearch"]
