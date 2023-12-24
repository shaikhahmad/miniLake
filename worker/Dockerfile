FROM ahmad/minilake:hadoop331
LABEL MAINTAINER="Muhammad Ahmad <ahmad6346@yahoo.com>"

ENV DATADIR=/opt/hadoop/dfs/data
RUN mkdir -p /opt/hadoop/dfs/data
VOLUME /opt/hadoop/dfs/data

ENV SPARK_PUBLIC_DNS=localhost
ENV SPARK_MASTER_ADDRESS=spark://master:7077

COPY run.sh /usr/local/sbin/run.sh
RUN chmod a+x /usr/local/sbin/run.sh
CMD ["run.sh"]