--EX 1
create table hw_emp as (select * from emp where 1=2);

select * from hw_emp;

desc hw_emp;

-- EX 2
alter table hw_emp add etc varchar(20);

-- EX 3
alter table hw_emp MODIFY etc varchar(100);

-- EX 4
alter table hw_emp rename COLUMN etc to remark;

-- EX 5
insert into hw_emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
select * from emp;

-- EX 6
alter table hw_emp add CONSTRAINT pk_hw_emp primary key (empno);

-- EX 7 
drop table hw_emp;