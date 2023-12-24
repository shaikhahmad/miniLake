FROM ahmad/minilake:hadoop331 AS base
LABEL MAINTAINER="Muhammad Ahmad <ahmad6346@yahoo.com>"
FROM jupyter/minimal-notebook:python-3.8
USER root

# RUN rm /etc/apt/sources.list.d/cuda.list
# RUN rm /etc/apt/sources.list.d/custom.list

RUN DEBIAN_FRONTEND=noninteractive apt update
RUN apt install openjdk-8-jdk -y
RUN rm -rf /var/lib/apt/lists/*

# RUN sed -i -e "s|http://archive.ubuntu.com|http://jp.archive.ubuntu.com|g" /etc/apt/sources.list \
#  && apt-get -y update  \
#  && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
#       sudo \
#       openjdk-8-jdk \
#       curl \
#       coreutils \
#       libc6-dev \
#  && rm -rf /var/lib/apt/lists/*

# ARG USERNAME=jovyan
# ARG GROUPNAME=users
# ARG UID=1000
# ARG GID=100

# RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#  && chmod 0440 /etc/sudoers.d/$USERNAME \
#  && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

# USER $USERNAME

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# Hadoop
COPY --from=base /opt/hadoop /opt/hadoop
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$PATH
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native:$LD_LIBRARY_PATH

# Spark
COPY --from=base /opt/spark /opt/spark
ENV SPARK_HOME=/opt/spark
ENV PYTHONHASHSEED=1
ENV PYSPARK_PYTHON=python3
ENV SPARK_CONF_DIR=$SPARK_HOME/conf
ENV PATH=$SPARK_HOME/sbin:$SPARK_HOME/bin:$PATH

# Hive
COPY --from=base /opt/hive /opt/hive
ENV HIVE_HOME=/opt/hive
ENV HIVE_CONF_DIR=$HIVE_HOME/conf
ENV PATH=$HIVE_HOME/sbin:$HIVE_HOME/bin:$PATH

RUN pip install -U pip   &&\
    pip install --no-cache-dir findspark

COPY run.sh /usr/local/sbin/run.sh
RUN chmod a+x /usr/local/sbin/run.sh
# USER $USERNAME
CMD ["run.sh"]
