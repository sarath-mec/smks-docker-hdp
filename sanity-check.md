Login to your datanode, create a Hadoop home directory for "root", and put some sample logfiles into it
```
localhost:randy$ docker exec -it docker_hdp_dn0.dev_1 bash
[root@dn0 /]# su hdfs
bash-4.2$ hdfs dfs -mkdir /user/root
bash-4.2$ hdfs dfs -chownr root /user/root
-chownr: Unknown command
bash-4.2$ hdfs dfs -chown root /user/root 
bash-4.2$ exit
exit
[root@dn0 /]# hdfs dfs -mkdir test
[root@dn0 /]# hdfs dfs -put /var/log/ambari-agent/ test/ 
```

Run the following Hive queries to create raw and derived wordcount tables from the logfiles:
```
[root@dn0 /]# hive
hive> create table loglines (line string) location '/user/root/test/';
hive>
create table words stored as orc as
select word, count(*) as count
from (
  select
    explode(split(line, " ")) as word
  from loglines
) a
group by word;
```
