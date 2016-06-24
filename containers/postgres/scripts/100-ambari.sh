#!/bin/bash
set -e

sed -i "s/\${ambariSchemaVersion}/2.2.2/g" /Ambari-DDL-Postgres-CREATE.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    alter user ambari with PASSWORD 'dev';
    GRANT ALL PRIVILEGES ON DATABASE ambari TO ambari;

    \connect ambari;

    CREATE SCHEMA ambari AUTHORIZATION ambari;
    ALTER SCHEMA ambari OWNER TO ambari;
    ALTER ROLE ambari SET search_path to 'ambari', 'public';

    ALTER ROLE ambari LOGIN ENCRYPTED PASSWORD 'dev';
    \i Ambari-DDL-Postgres-CREATE.sql 
EOSQL
chown postgres /pg_hba.conf
mv /pg_hba.conf /var/lib/postgresql/data/
