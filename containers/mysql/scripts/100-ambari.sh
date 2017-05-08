#!/bin/bash
set -e

cd ~/
wget https://raw.githubusercontent.com/apache/ambari/branch-2.5/ambari-server/src/main/resources/Ambari-DDL-Postgres-CREATE.sql
sed -i "s/\${ambariSchemaVersion}/2.5.0/g" Ambari-DDL-Postgres-CREATE.sql

mysql --user=root --password=admin

--port 3306

