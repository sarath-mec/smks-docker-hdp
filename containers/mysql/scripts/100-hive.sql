create user 'ambari'@'%' identified by 'dev';
grant all privileges on *.* to 'ambari'@'%'; 
create user 'ambari'@'localhost' identified by 'dev';
grant all privileges on *.* to 'ambari'@'localhost';
create user'ambari'@'ambari-server.dev' identified by 'dev';
grant all privileges on *.* to 'ambari'@'ambari-server.dev';
flush privileges;

create user 'hive'@'%' identified by 'dev';
grant all privileges on *.* to 'hive'@'%'; 
create user 'hive'@'localhost' identified by 'dev';
grant all privileges on *.* to 'hive'@'localhost';
create user'hive'@'dn0.dev' identified by 'dev';
grant all privileges on *.* to 'hive'@'dn0.dev';
flush privileges;
