-- EX 1
create table emp2 as select * from emp;
create table dept2 as select * from dept;
create table salgrade2 as select * from salgrade;

select * from emp2;
select * from dept2;
select * from salgrade2;
------------------------------------------------------------------------------------
-- EX 2
insert into dept2 VALUES (50, 'OLACLE', 'Seoul');
insert into dept2 VALUES (60, 'SQL', 'Jeju');
insert into dept2 VALUES (70, 'DDL', 'Pusan');
insert into dept2 VALUES (80, 'DML', 'Incheon');
------------------------------------------------------------------------------------
-- EX 3
insert into emp2 (empno, ename, job, mgr, hiredate, sal, comm)
VALUES ( 8000, 'HAN', 'DEVELOPER', 7839, '2019/09/04', 6000, 500);
------------------------------------------------------------------------------------
-- EX 4
update emp2 
set deptno = 80 
where sal >= (select avg(sal) from emp) ;
------------------------------------------------------------------------------------
-- EX 5
update emp2
set sal = sal*1.1 , deptno = 70
where hiredate >= (select max(hiredate) from emp2 where deptno =10);  
------------------------------------------------------------------------------------
-- EX 6
delete 
from emp2 
where empno in (select e.empno
                        from emp2 e join salgrade2 s
                        on e.sal between s.losal and s.hisal
                        where s.grade = 5);
------------------------------------------------------------------------------------
-- EX 7
commit;
          