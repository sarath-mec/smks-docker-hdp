#!/bin/bash
set -e

cd ~/
wget $AMBARI_DDL_URL_MYSQL
sed -i "s/\${ambariSchemaVersion}/2.5.0/g" Ambari-DDL-MySQL-CREATE.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    create database ambari;
    create user ambari with password 'dev';
    GRANT ALL PRIVILEGES ON DATABASE ambari TO ambari;

    CREATE SCHEMA ambari AUTHORIZATION ambari;
    ALTER SCHEMA ambari OWNER TO ambari;
    ALTER SCHEMA public OWNER to ambari;

    ALTER ROLE ambari SET search_path to 'ambari', 'public';

    \connect ambari ambari;
    \i Ambari-DDL-Postgres-CREATE.sql 
EOSQL

cp /pg_hba.conf /var/lib/postgresql/data/
