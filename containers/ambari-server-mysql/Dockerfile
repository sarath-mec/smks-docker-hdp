FROM centos:6@sha256:4bea14b310a92cb334a0a47578f01a6f81b020577381fc2e1fbee4edbf37717e
ARG AMBARI_REPO_URL
RUN yum install -y wget sudo net-tools
RUN wget -nv ${AMBARI_REPO_URL} -O /etc/yum.repos.d/ambari.repo
RUN yum install -y ambari-server
RUN ambari-server setup --database=mysql --databasehost=mysql.dev --databaseport=3306  --databasename=hdp_db --databaseusername=ambari --databasepassword=dev --silent
ADD scripts/start.sh /start.sh
CMD /start.sh
