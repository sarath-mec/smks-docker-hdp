FROM postgres
ADD scripts/* /docker-entrypoint-initdb.d/
RUN apt-get update
RUN apt-get install -y wget
RUN wget https://raw.githubusercontent.com/apache/ambari/branch-2.2/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql
ADD pg_hba.conf /
