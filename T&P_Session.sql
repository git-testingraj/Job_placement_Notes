--SQL Interview Questions-----

Create database SQL_INTERVIEW
---JOINS = CROSS PRODUCT + CONDITION

--A  B
--1  1
--1  1

create table A (c1 int )
create table B (c2 int ) -- varchar 0-9,a-z,sc

select * from A
select * from B

truncate table A 
truncate table B

insert into A values (1),(1),(2),(3)
insert into B values (1),(2),(4),(NULL)

select * from A
select * from B

select * from A inner join B ON A.c1= B.c2

select * from A full join B ON A.c1= B.c2

select * from A right join B ON A.c1= B.c2

select * from A
select * from B

select * from A left join B ON A.c1= B.c2

--statement execution order 
select dept_id,sal from emp where sal in (select min(sal) from emp 
group by dept_id 
having count(*)>1 order by dept_id desc;

--Order Execution 
--1.FROM/JOIN - first
--2.WHERE 
--3.GROUP BY 
--4.HAVING
--5.SELECT
--6.ORDER BY

code	name Lead  manager
c		ram		b	 c
b		varun   a    c     
a		arun    c    b

--diffrence 

select * from A , B where A.c1 = b.c2 --equi-join always acts as inner join inner join 

select * from A a1 , A a2 where a1.c1 = a2.c1 --self join - we use one table 



--SQL server function 
--CHARINDEX
--SUBSTRING
--REPLACE
--CONACT

  	 
--A			B    AB
--123     123    123123
--2345    2345   234523
--1234    234    123423

--we need to combine A and B and we need to display only 6 digits 

create table AB (A int,B int)

insert into AB values (123,123),(2345,2345),(1234,234)

select * from AB

select substring(CONCAT(A,B),1,6) from AB

--NAME
--Rahul Patil
--Varun Kumar 
--Shahil@patil
--Shital_Chavan

--first_name  Last_name 
--Rahul		  Patil
--Varun		  Kumar
--Sahil		  Patil
--Shital      Chavan

select name = case
when substring(name ,1,CHARINDEX('@',name)-1) as Firstname 
 then substring(name ,CHARINDEX('@',name )+1,LEN(name)) as LastName

from fullname 

select CHARINDEX('@','Shahil@patil')

CASE WHEN 
NAME =

--CASE 
--CASE with Update 
create table fullname (name varchar(50))

insert into fullname values ('Rahul Patil'),('Varun Kumar'),('Shahil@patil'),('Shital_Chavan')

select (case when name like '%@%' then substring(name,1,charindex('@',name)-1)
         when name like '% %' then SUBSTRING(name,1,charindex(' ',name)-1)
		 when name like '%[_]%' then SUBSTRING(name,1,charindex('_',name)-1)
		end),
		(case when name like '%@%' then substring (name,charindex('@',name)+1,LEN(name)) end)
		as lname from fullname
select * into EMP_DETAILS from 
(select 
case when name like'%[ ]%' then substring(name,1,charindex(' ',name)-1)
	 when name like'%[@]%' then substring(name,1,charindex('@',name)-1)
	 when name like'%[_]%' then substring(name,1,charindex('_',name)-1) end firstname,
case when name like'%[ ]%' then substring(name,charindex(' ',name)+1,len(name))
	 when name like'%[@]%' then substring(name,charindex('@',name)+1,len(name))
	 when name like'%[_]%' then substring(name,charindex('_',name)+1,len(name)) end lastname from fullname) a

--We need to write store procedure 
Firstname Lastname 

select * from EMP_DETAILS

create proc sp_Conversion
as
begin

select 
case when firstname = lower(firstname) then upper(firstname)
	else firstname end as FirstName ,
case  when lastname = lower(lastname) then upper(lastname)
	 else lastname end as LastName
from EMP_DETAILS

end 

select * from EMP_DETAILS

exec sp_Conversion
--we need to change all the first name and last name with capital letter 


--Diffrence between rank and dens_rank
--What is the diffrence between having and where clause 
--diffrence between delete , drop and trucate?
--Suppose i am having table in that we want to count how many time the same record is getting loaded?
--Duplicate 

--EMP and dept Location 

--find out maximum salary of an employee for each loaction along with its department?

--max()
--join
--group by loc,dept

select MIN(e_sal) from employee 

select MIN(E_SAL) from employee where E_SAL >()

select MAX(E_SAL) from employee where E_SAL in (
select top 3  E_SAL  from employee order by E_SAL asc )

select MAX(E_SAL) from employee where E_SAL in (
select top 2   E_SAL  from employee order by E_SAL asc )

--all the details second minimum salary employee 

select * from employee e1  
where 3 = (select count(e2.E_SAL) from employee e2 where e1.E_SAL <= e2.E_SAL  )

select * from employee e1 
where 4 = (select distinct(COUNT(E_SAL)) from employee e2 where e1.E_SAL >= e2.E_SAL )

Select * from
(select * , Dense_rank () over ( order by E_SAL Desc) as ranking from Employee) 
as Temp where ranking = 3

select MAX(E_Sal) from employee


------------------------------------------------
--Display hihest marks of each subject along with student
create table student_marks(Name varchar(20),Science int,Maths int,English int)

insert into student_marks values ('Mohan',4,9,1),('amit',2,3,6),('Amar',0,1,4),('Sagar',5,7,2),('Kiran',7,6,0)

select * from student_marks

--Science > Maths> English as Science
--Maths > Science > English as Maths
--English > Maths > Science as English
select * from student_marks
--Part two output
select name,Case
			when Science > Maths and  Maths > English  then  Science
			when Maths > Science and Science > English  then  Maths
			When English > Maths and Maths > Science then English
			end as Student_Marks 
from student_marks

--Part one
select name,Case
			when Science > Maths and  Maths > English  then  'Science'
			when Maths > Science and Science > English  then  'Maths'
			When English > Maths and Maths > Science then 'English'
			end as Student_Marks 
from student_marks

--

--Part one output
--Name	Max_Marks
--amit	English
--Amar	English
--Sagar	Maths
--Kiran	Science
--Mohan Maths

--English > maths >
--Part Two output
--Name	Max_Marks
--amit		6
--Amar		4
--Sagar		7
--Kiran		7
--Mohan		9

--Focused Topics in SQL 
--Constraint - Unique , Pk , FK ,Default , NOT NULL, Check
--Clause - WHERE, Order by ,Group by*** , Having* (diff between where and having), IS NULL
--Operators - Arithamtic operators by using case statement, LIKE***, IN,Between
--Aggrgate Functions - Max*, Min*,avg,sum,count *** 
--Joins*** (Very important) -- inner join , outer,left,right
--Self Join, equi_join
--SET operator - union,union all,intersection*,EXCEPT/MINUS***
--Anonotical functions - Rank**, dense_rank** and Row_number(delete duplicates)**
--SQL system defined keywords :TOP,CASE****,OVER BY , PARTITION BY***
--Statements - DELETE,DROP,TRUNCATE, case with updates ,ALTER constraint*
--SQL Server Function : Cast,convert,substring,charindex,replace ,concat,concat_ws,stuff,coalese**

--When more depth Knowlege then
--Depth SQL : View**, SP*, trigger* , INDEX 
--Encrytion and decrytion : EncryptByKey,DecryptByKey
--Pivot and unpivot



select * from EMPLOYEE

--Write SQL query to incresee even id employees by 1000 and odd employees by 1500.
select *, case 
			when EID%2 =0 Then E_sal + 1000 
			When EID %2 =1 then E_SAL + 1500
			end as SAL_INC
from EMPLOYEE

--------------------------------------------------------------------------
--in sales table, 
-- Date			fruits  amount  
-- 01/01/22		mango	20  
-- 01/01/22		apple	30 --('2022-01-01','Apple',30)
-- 05/04/22		mango	50  --('2022-04-05','Mango',20)
-- 05/04/22		apple	30 --('2022-04-05','Apple',20)

--write a query to get difference between amt of fruits date wise
--output  
--Date		  Difference 
--01/01/22    10
--05/04/22    20

create table Fruit_Sales (Date_ID date,Fruits varchar(30),Amount int)

insert into Fruit_Sales values ('2022-01-01','Apple',50),('2022-01-01','Mango',20),('2022-01-01','Apple',30),
('2022-04-05','Mango',50),('2022-04-05','Apple',20)


SELECT * FROM Fruit_Sales

select DATE_id, max(amount)-min(amount) as DIFFRENCE 
from Fruit_Sales
group by DATE_ID

--
select Date_ID, 
Max(amount) over(partition by date_id order by amount) -Min(amount) over(partition by date_id order by amount)
from Fruit_Sales  

--2022-01-01	20
--2022-01-01	30



