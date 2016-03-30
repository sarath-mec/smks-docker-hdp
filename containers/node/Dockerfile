FROM centos
RUN yum install -y wget
RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.2.1.1/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.4.0.0/hdp.repo -O /etc/yum.repos.d/hdp.repo
RUN yum install -y sudo tar unzip curl openssl-devel mysql-connector-java postgresql-jdbc mysql-community-* krb5-server krb5-libs krb-auth-dialog krb5-workstation
RUN yum install -y ambari-agent
RUN yum install -y hadoop*
RUN yum install -y zookeeper
RUN yum install -y hive_*
RUN yum install -y phoenix_*
RUN yum install -y ranger*
RUN yum install -y storm_*
RUN yum install -y kafka_*
RUN yum install -y pig_*
RUN yum install -y datafu_*
RUN yum install -y spark_*
RUN yum install -y falcon_*
RUN yum install -y oozie_*
RUN yum install -y lucidworks-hdpsearch
RUN yum install -y lzo snappy-devel rpcbind
RUN rm /etc/yum.repos.d/hdp*.repo
ADD scripts/start.sh /start.sh
CMD /start.sh
