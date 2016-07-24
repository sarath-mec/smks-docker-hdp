FROM centos:6
RUN yum install -y wget sudo net-tools
RUN wget -nv http://public-repo-1.hortonworks.com/HDP-LABS/Projects/Erie-Preview/ambari/2.4.0.0-4/centos6/ambari.repo -O /etc/yum.repos.d/ambari.repo
#RUN wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.2.2.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
RUN yum install -y ambari-server postgresql-jdbc
RUN ambari-server setup --database=postgres --databasehost=postgres.dev --databaseport=5432 --databasename=ambari --postgresschema=ambari  --databaseusername=ambari --databasepassword=dev --silent
RUN ambari-server setup --jdbc-db postgres --jdbc-driver=/usr/share/java/postgresql-jdbc.jar
ADD scripts/start.sh /start.sh
CMD /start.sh
