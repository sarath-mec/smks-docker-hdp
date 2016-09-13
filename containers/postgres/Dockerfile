FROM postgres
ARG DDL_URL
ADD scripts/* /docker-entrypoint-initdb.d/
RUN apt-get update -y
RUN apt-get install -y wget
RUN wget ${DDL_URL}
ADD pg_hba.conf /
