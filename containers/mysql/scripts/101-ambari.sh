#!/bin/bash
set -e

cd ~/
wget $(AMBARI_DDL_URL_MYSQL)
sed -i "s/\${ambariSchemaVersion}/2.5.0/g" Ambari-DDL-MySQL-CREATE.sql

mysql < /Ambari-DDL-MySQL-CREATE.sql
