#!/bin/bash
set -e

mkdir -p /home/mysql
chmod 777 /home/mysql
cd /home/mysql
wget $AMBARI_DDL_URL_MYSQL
sed -i "s/\${ambariSchemaVersion}/2.5.0/g" Ambari-DDL-MySQL-CREATE.sql

mysql < Ambari-DDL-MySQL-CREATE.sql
