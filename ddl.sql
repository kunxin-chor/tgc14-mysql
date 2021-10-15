/* show all databases on server */
show databases;

/* create new database */
create database swimming_school;

/* switch to a database (i.e make it active )*/
use swimming_school;

/* see the current database */
SELECT DATABASE();

/* create a table */
create table parents (
    parent_id int unsigned auto_increment primary key,
    first_name varchar(200) not null,
    last_name varchar(200) not null
) engine = innodb;

/* show all the tables in the current active database */
show tables;

/* check the columns of a table */
describe parents;

/* how to add rows to table */
/*insert into <table name> (<cols>) values (<values>)*/
insert into parents (first_name, last_name) values ('Foo', 'Lin Lin');