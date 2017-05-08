#!/bin/bash
set -e

#cd /mysql
#wget $AMBARI_DDL_URL_MYSQL
#sed -i "s/\${ambariSchemaVersion}/2.5.0/g" Ambari-DDL-MySQL-CREATE.sql

#mysql --user=ambari --password=dev < Ambari-DDL-MySQL-CREATE.sql
whoami
echo $MYSQL_ROOT_PASSWORD
