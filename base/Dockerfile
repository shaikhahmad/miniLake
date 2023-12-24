FROM ubuntu:20.04
LABEL MAINTAINER="Muhammad Ahmad <ahmad6346@yahoo.com>"

RUN DEBIAN_FRONTEND=noninteractive apt update
RUN apt install openjdk-8-jdk -y
RUN rm -rf /var/lib/apt/lists/*

# ARG USERNAME=jovyan
# ARG GROUPNAME=users
# ARG UID=1000
# ARG GID=100

# RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#  && chmod 0440 /etc/sudoers.d/$USERNAME

# USER $USERNAME

COPY setups/* .

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# Hadoop
ARG HADOOP_VERSION=3.3.4
ENV HADOOP_HOME=/opt/hadoop

RUN set -x \
 && mkdir $HADOOP_HOME  \
#  && chown $USERNAME:$GROUPNAME -R $HADOOP_HOME \
 && mv hadoop-$HADOOP_VERSION.tar.gz /tmp/hadoop.tar.gz \
 && tar -xf /tmp/hadoop.tar.gz -C $HADOOP_HOME --strip-components 1 \
 && mkdir $HADOOP_HOME/logs \
 && rm /tmp/hadoop*

ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native:$LD_LIBRARY_PATH

# Spark
ARG SPARK_VERSION=3.3.1
ENV SPARK_HOME=/opt/spark

RUN set -x \
 && mkdir $SPARK_HOME \
 && mv spark-$SPARK_VERSION-bin-hadoop3.tgz /tmp/spark.tgz \
 && tar -xf /tmp/spark.tgz -C $SPARK_HOME --strip-components 1 \
 && rm /tmp/spark* \
 && mv postgresql-42.3.2.jar $SPARK_HOME/jars/postgresql-42.3.2.jar

ENV PYTHONHASHSEED=1
ENV PYSPARK_PYTHON=python3
ENV SPARK_CONF_DIR=$SPARK_HOME/conf
ENV PATH=$SPARK_HOME/sbin:$SPARK_HOME/bin:$PATH

# Hive
ARG HIVE_VERSION=3.1.3
ENV HIVE_HOME=/opt/hive

RUN set -x \
 && mkdir $HIVE_HOME \
 && mv apache-hive-$HIVE_VERSION-bin.tar.gz /tmp/hive.tar.gz \
 && tar -xf /tmp/hive.tar.gz -C $HIVE_HOME --strip-components 1 \
 && rm /tmp/hive*

#RUN rm $HIVE_HOME/lib/guava-*.jar \
# && cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-*.jar $HIVE_HOME/lib/
#RUN mv /opt/hive/lib/log4j-slf4j-impl-2.6.2.jar /opt/hive/lib/log4j-slf4j-impl-2.6.2.jar.bak

ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV PATH=$HIVE_HOME/sbin:$HIVE_HOME/bin:$PATH

# Config
COPY conf/core-site.xml $HADOOP_CONF_DIR/
COPY conf/hdfs-site.xml $HADOOP_CONF_DIR/
COPY conf/yarn-site.xml $HADOOP_CONF_DIR/
COPY conf/mapred-site.xml $HADOOP_CONF_DIR/
COPY conf/workers $HADOOP_CONF_DIR/
COPY conf/spark-defaults.conf $SPARK_CONF_DIR/
COPY conf/log4j.properties $SPARK_CONF_DIR/
COPY conf/hive-site.xml $HIVE_CONF_DIR/

RUN ln $HADOOP_CONF_DIR/workers $SPARK_CONF_DIR/ \
 && ln $HIVE_CONF_DIR/hive-site.xml $SPARK_CONF_DIR/

# Entry point
COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
RUN chmod a+x /usr/local/sbin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
