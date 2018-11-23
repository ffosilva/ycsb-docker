FROM openjdk:8-jre

ARG YCSB_VERSION="0.15.0"

RUN apt-get update \
  && apt-get install -y python2.7-minimal \
  && ln -s /usr/bin/python2.7 /usr/bin/python

RUN curl --progress-bar -sLo /tmp/ycsb-${YCSB_VERSION}.tar.gz https://github.com/brianfrankcooper/YCSB/releases/download/${YCSB_VERSION}/ycsb-${YCSB_VERSION}.tar.gz \
  && mkdir -p /opt \
  && cd /opt \
  && tar -xvf /tmp/ycsb-${YCSB_VERSION}.tar.gz \
  && mv ycsb-${YCSB_VERSION} /opt/ycsb \
  && rm -rf /tmp/ycsb-${YCSB_VERSION}.tar.gz

WORKDIR /opt/ycsb

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bin/ycsb"]
