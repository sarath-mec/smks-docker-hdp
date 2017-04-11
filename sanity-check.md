Login to your datanode, create a Hadoop home directory for "admin", and put some sample logfiles into it
```
localhost:randy$ docker exec -it compose_dn0.dev_1 bash
[root@dn0 /]# su hdfs
bash-4.2$ mkdir admin
bash-4.2$ cd admin
bash-4.2$ hadoop fs -mkdir /user/admin
bash-4.2$ hadoop fs -chown admin /user/admin
bash-4.2$ hadoop fs -copyFromLocal /var/log/dracut.log /user/admin
bash-4.2$ hadoop fs -ls /user/admin
```

Run the following Hive queries to create raw and derived wordcount tables from the logfiles:
```
localhost:randy$ docker exec -it compose_dn1.dev_1 bash
[root@dn1 /]# su hdfs
bash-4.2$ hive
hive> create table loglines (line string);
hive> load data local inpath '/var/log/ambari-agent/' overwrite into table loglines;
hive> create table loglines_ext (line string);
hive> load data local inpath '/admin/data/' overwrite into table loglines_ext;
hive> create table words as
select word, count(*) as count
from (
  select
    explode(split(line, " ")) as word
  from loglines
) a
group by word;

```
