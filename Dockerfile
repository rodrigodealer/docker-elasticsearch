FROM java:8

ENV ES_PKG_NAME elasticsearch-2.1.0

RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

RUN useradd elasticsearch

ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

WORKDIR /data

RUN chown -R elasticsearch:elasticsearch /data /elasticsearch

USER elasticsearch

EXPOSE 9200
EXPOSE 9300

CMD ["/elasticsearch/bin/elasticsearch"]
