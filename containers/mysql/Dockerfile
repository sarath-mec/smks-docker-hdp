FROM postgres@sha256:3b51a72ca2642f24fa782c2fb99ddb0d29cbcd38f32639c98a80966a25ae2a64
RUN apt-get update -y
RUN apt-get install -y wget
ARG AMBARI_DDL_URL_MYSQL
ENV AMBARI_DDL_URL_MYSQL=${AMBARI_DDL_URL_MYSQL}
#ADD pg_hba.conf /pg_hba.conf
#ADD scripts/* /docker-entrypoint-initdb.d/
#RUN mkdir /home/postgres
#RUN chown postgres /pg_hba.conf /home/postgres
#RUN chown postgres /var/lib/postgresql/data
COPY /scripts/setup.sh /mysql/setup.sh
COPY setup.sql /mysql/setup.sql
RUN /mysql/setup.sh
