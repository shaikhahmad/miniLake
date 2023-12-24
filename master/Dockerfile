FROM ahmad/minilake:hadoop331
LABEL MAINTAINER="Muhammad Ahmad <ahmad6346@yahoo.com>"

RUN DEBIAN_FRONTEND=noninteractive apt update
RUN apt install coreutils nano  -y
RUN rm -rf /var/lib/apt/lists/*

ENV NAMEDIR=/opt/hadoop/dfs/name
RUN mkdir -p /opt/hadoop/dfs/name
VOLUME /opt/hadoop/dfs/name

#ENV NAMESECONDDIR=/opt/hadoop/dfs/namesecondary
#RUN mkdir -p /opt/hadoop/dfs/namesecondary
#VOLUME /opt/hadoop/dfs/namesecondary

ENV SPARK_PUBLIC_DNS=localhost
ENV SPARK_LOGS_HDFS_PATH=/var/log/spark
ENV SPARK_JARS_HDFS_PATH=/spark/jars

COPY run.sh /usr/local/sbin/run.sh
RUN chmod a+x /usr/local/sbin/run.sh
CMD ["run.sh"]