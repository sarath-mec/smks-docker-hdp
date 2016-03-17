FROM centos
RUN yum install -y wget
RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.2.1.1/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN yum install -y ambari-agent
ADD scripts/start.sh /start.sh
CMD /start.sh
