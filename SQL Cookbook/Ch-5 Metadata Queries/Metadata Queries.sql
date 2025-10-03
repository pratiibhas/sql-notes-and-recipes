-- This chapter presents recipes that allow you to find information about a given schema. 

-- 5.1 Listing Tables in a Schema
select table_name
from information_schema.tables
where table_schema = 'practice';
-- the information schema, is a set of views defined by the ISO SQL standard.

-- 5.2 Listing a Table’s Columns
/*Problem
You want to list the columns in a table, along with their data types, and their position
in the table they are in.*/
select column_name, data_type, ordinal_position
from information_schema.columns
where table_schema = 'practice'
and table_name = 'EMP';

-- 5.3 Listing Indexed Columns for a Table
/* You want list indexes, their columns, and the column position (if available) in the
index for a given table.*/

use practice;
show index from emp_table;

-- 5.4 Listing Constraints on a Table

select a.table_name,
a.constraint_name,
b.column_name,
a.constraint_type
from information_schema.table_constraints a,
information_schema.key_column_usage b
where a.table_name = 'emp_table'
and a.table_schema = 'practice'
and a.table_name = b.table_name
and a.table_schema = b.table_schema
and a.constraint_name = b.constraint_name;

-- 5.5 Listing Foreign Keys Without Corresponding Indexes
/*Problem

You want to list tables that have foreign key columns that are not indexed. For exam‐
ple, you want to determine whether the foreign keys on table EMP are indexed.*/

-- 1. Retrieve Index Information 
SHOW INDEX FROM emp_table;
-- 2. Retrieve Foreign Key Information (INFORMATION_SCHEMA.KEY_COLUMN_USAGE)
SELECT 
    TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'emp_table' AND TABLE_SCHEMA = DATABASE();

-- 3. Compare Foreign Keys with Indexed Columns
SELECT DISTINCT k.COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE k
LEFT JOIN INFORMATION_SCHEMA.STATISTICS s
ON k.TABLE_NAME = s.TABLE_NAME 
AND k.COLUMN_NAME = s.COLUMN_NAME
AND k.TABLE_SCHEMA = s.TABLE_SCHEMA
WHERE k.TABLE_NAME = 'emp_table' 
AND k.TABLE_SCHEMA = DATABASE()
AND s.COLUMN_NAME IS NULL; -- Columns in foreign keys but not indexed

-- 5.6 Using SQL to Generate SQL
/* Problem
You want to create dynamic SQL statements, perhaps to automate maintenance tasks.
You want to accomplish three tasks in particular: count the number of rows in your
tables, disable foreign key constraints defined on your tables, and generate insert
scripts from the data in your tables.*/

/* generate SQL to count all the rows in all your tables */
select concat('select count(*) from ',table_name,';') as cnts
from (select table_name
from information_schema.tables
where table_schema = 'practice') x;

/* disable foreign keys from all tables */
with user_constraints as(select a.table_name,
a.constraint_name,
b.column_name,
a.constraint_type
from information_schema.table_constraints a,
information_schema.key_column_usage b
where a.table_name = 'emp_table'
and a.table_schema = 'practice'
and a.table_name = b.table_name
and a.table_schema = b.table_schema
and a.constraint_name = b.constraint_name
) 
select concat('alter table ',table_name,
'disable constraint ',constraint_name,';') as  cons
from user_constraints;

/* generate an insert script from some columns in table EMP */
select concat('insert into emp(empno,ename,hiredate) ',
'values( ',empno, ',','''',ename
,''',str_to_date(','''',hiredate,''', ''%Y-%m-%d'') );')as  inserts
from emp_table
where deptno = 10;

-- 5.7 Describing the Data Dictionary Views in an Oracle Database
/* Problem
You are using Oracle. You can’t remember what data dictionary views are available to
you, nor can you remember their column definitions. Worse yet, you do not have
convenient access to vendor documentation.*/


/*This is an Oracle-specific recipe. Not only does Oracle maintain a robust set of data
dictionary views, but there are also data dictionary views to document the data dic‐
tionary views. It’s all so wonderfully circular

Query the view named DICTIONARY to list data dictionary views and their
purposes:
select table_name, comments
from dictionary
order by table_name;


Query DICT_COLUMNS to describe the columns in a given data dictionary view:
select column_name, comments
from dict_columns
where table_name = 'ALL_TAB_COLUMNS';*/