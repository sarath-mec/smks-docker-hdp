FROM mysql@sha256:e44b9a3ae88db013a3e8571a89998678ba44676ed4ae9f54714fd31e108f8b58
RUN apt-get update -y
RUN apt-get install -y wget
ARG AMBARI_DDL_URL_MYSQL
ARG MYSQL_ROOT_PASSWORD
ENV AMBARI_DDL_URL_MYSQL=${AMBARI_DDL_URL_MYSQL}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
RUN wget -P /mysql/ $AMBARI_DDL_URL_MYSQL
ADD scripts/100-setup_db.sql /docker-entrypoint-initdb.d/
ADD scripts/101-debug.sh /mysql/101-debug.sh
RUN chmod +x /mysql/101-debug.sh
RUN /mysql/101-debug.sh
#ADD pg_hba.conf /pg_hba.conf
#RUN chown postgres /pg_hba.conf /home/postgres
#RUN chown postgres /var/lib/postgresql/data
