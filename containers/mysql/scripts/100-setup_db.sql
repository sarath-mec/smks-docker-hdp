create database ambari;
create user 'ambari'@'%' identified by 'dev';
grant all privileges on ambari.* to 'ambari'@'%';
create user 'ambari'@'localhost' identified by 'dev';
grant all privileges on ambari.* to 'ambari'@'localhost';
flush privileges;

create database hive;
create user 'hive'@'%' identified by 'dev';
grant all privileges on hive.* to 'hive'@'%';
create user 'hive'@'localhost' identified by 'dev';
grant all privileges on hive.* to 'hive'@'localhost';
flush privileges;

create database oozie;
create user 'oozie'@'%' identified by 'dev';
grant all privileges on oozie.* to 'oozie'@'%';
create user 'oozie'@'localhost' identified by 'dev';
grant all privileges on oozie.* to 'oozie'@'localhost';
flush privileges;

create user 'ranger'@'%' identified by 'dev';
create user 'ranger'@'localhost' identified by 'dev';

create database ranger;
create user 'rangeradmin'@'%' identified by 'dev';
grant all privileges on ranger.* to 'rangeradmin'@'%';
create user 'rangeradmin'@'localhost' identified by 'dev';
grant all privileges on ranger.* to 'rangeradmin'@'localhost';
flush privileges;

create database rangerkms;
create user 'rangerkms'@'%' identified by 'dev';
grant all privileges on rangerkms.* to 'rangerkms'@'%';
create user 'rangerkms'@'localhost' identified by 'dev';
grant all privileges on rangerkms*.* to 'rangerkms'@'localhost';
flush privileges;

#use ambari;
#source /mysql/Ambari-DDL-MySQL-CREATE.sql;
