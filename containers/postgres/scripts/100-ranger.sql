create user ranger;
alter user ranger with PASSWORD 'dev';

create user rangeradmin;
alter user rangeradmin with PASSWORD 'dev';
create database ranger;
alter database ranger owner to rangeradmin;
create user rangerkms;
alter user rangerkms with PASSWORD 'dev';
create database rangerkms;
alter database rangerkms owner to rangerkms;
