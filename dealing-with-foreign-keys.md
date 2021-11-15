# So you want to add a Foreign Key

The problems with adding foreign keys late in a project is that they usually clash with the existing data
or table structure. So this guide is to show you how to create foreign keys when you have existing data.
The important thing here is that to make we keep all the existing data unchanged.

## The setup
First, log into your MySQL client with:
```
mysql -u root
```

Copy and paste the following MySQL commands, which is to create a book table:

```
create database library;

use library;

create table books (
    book_id int unsigned auto_increment primary key,
    title varchar(200) not null,
    isbn varchar(200) not null
) engine = innodb;
```

Notice that the books table has no foreign keys yet.

## Add in new books:
Use the following SQL commands to add insome new books:

```
insert into books (title, isbn) values ("The Lord of the Rings", "123-123-123-123"), ("Harry Potter and the Goblet of Fire", "124-124-124-124"), ("A Game of Throne", "125-125-125-125");
```

Now what we want to do is the add in `authors`, and make it such that every book is related to at least one author. How can we do that while preserving all the rows in the `books` table so far.

## Create the authors table first
How we achieve this is to create the `authors` table first. 
```
create table authors (
    author_id int unsigned auto_increment primary key,
    name varchar(200)
) engine = innodb;
```

## Insert a default author
Before we create the foreign key between the `books` and `authors` table, we insert in a default author first.

```
insert into authors (name) values ('Default');
```

If you do a `select * from authors` you should be able to see the new author.

## Add in the foreign key to `books`
Now that we have the `authors` table, and one row inside it, we are going to add the foreign key to `books`


First, we add in the new `author_id` column, and give it
a default value of `1` if no values are provided. 
```
alter table books add column author_id int unsigned not null default 1;
```

If you run `select * from books`, you will see that there is a new column named `author_id` and they were all have the values of `1`, this is because of the `default 1` in the SQL command above.

Now we can add the foreign key to the `books` table:
```
alter table books add constraint fk_books_authors
  foreign key (author_id) references authors(author_id);
```

Since all the existing rows in the `books` table already have value of `1`, and we do have an author with `author_id` of `1`, we have no issues add in the new foreign key constraint.

Now we just have to add in the proper authors for the three existing books and reassign them to the proper authors later, either via a MySQL client or the command line.