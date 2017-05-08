create user 'ambari'@'%' identified by 'dev';
grant all privileges on *.* to 'ambari'@'%';
create user 'ambari'@'localhost' identified by 'dev';
grant all privileges on *.* to 'ambari'@'localhost';
flush privileges;

create user 'hive'@'%' identified by 'dev';
grant all privileges on *.* to 'hive'@'%';
create user 'hive'@'localhost' identified by 'dev';
grant all privileges on *.* to 'hive'@'localhost';
flush privileges;

create user 'oozie'@'%' identified by 'dev';
grant all privileges on *.* to 'oozie'@'%';
create user 'oozie'@'localhost' identified by 'dev';
grant all privileges on *.* to 'oozie'@'localhost';
flush privileges;

create user 'ranger'@'%' identified by 'dev';
grant all privileges on *.* to 'ranger'@'%';
create user 'ranger'@'localhost' identified by 'dev';
grant all privileges on *.* to 'ranger'@'localhost';
flush privileges;

create user 'rangeradmin'@'%' identified by 'dev';
grant all privileges on *.* to 'rangeradmin'@'%';
create user 'rangeradmin'@'localhost' identified by 'dev';
grant all privileges on *.* to 'rangeradmin'@'localhost';
flush privileges;

create user 'rangerkms'@'%' identified by 'dev';
grant all privileges on *.* to 'rangerkms'@'%';
create user 'rangerkms'@'localhost' identified by 'dev';
grant all privileges on *.* to 'rangerkms'@'localhost';
flush privileges;

create database hdp_db;
use hdp_db;
source /mysql/Ambari-DDL-MySQL-CREATE.sql;
