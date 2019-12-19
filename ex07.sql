select sum(sal) 
from emp;

select sum(sal), round(avg(sal),2) 
from emp;

select sum(sal), round(avg(sal),2), min(sal), max(sal) 
from emp;

select sum(sal), round(avg(sal),2), min(sal), max(sal), round(VARIANCE(sal),2) 
from emp;

select sum(sal), round(avg(sal),2), min(sal), max(sal), round(VARIANCE(sal),2), round(STDDEV(sal),2) 
from emp;

select count(*) 
from emp;

select count(mgr)
from emp;

select count(deptno)
from emp;

select count(deptno), count(distinct deptno) 
from emp;

select empno, count(empno)
from emp; -- 에러 발생! 여러 행이 결과로 출력되는 변수와 그룹 함수는 함께 셀렉트 불가

select max(hiredate), min(hiredate)
from emp;

select sum(sal), min(sal), max(sal), round(avg(sal)), round(VARIANCE(sal)), round(STDDEV(sal))
from emp
where deptno =30;


select deptno, min(sal), max(sal), round(avg(sal))
from emp
group by deptno; 

select sum(comm), avg(comm), avg(nvl(comm,0)) 
from emp;

select job, avg(sal), min(sal), max(sal)
from emp
group by job;

select mgr, avg(sal)
from emp
group by mgr;

select mgr, avg(sal)
from emp
where mgr is not null
group by mgr;

select mgr, avg(sal)
from emp
group by mgr
having mgr is not null;

select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno, job;

select deptno, round(avg(sal),1), min(sal), max(sal), count(*)
from emp
group by deptno
order by deptno;

select job, count(*)
from emp
group by job
having count(*) >= 3;

select to_char(hiredate,'YYYY'), avg(sal), max(sal), min(sal)
from emp
group by to_char(hiredate,'YYYY');

select DISTINCT to_char(hiredate,'YYYY'), deptno, count(empno)
from emp 
group by to_char(hiredate,'YYYY'), deptno
order by to_char(hiredate,'YYYY');

select count(*), nvl2(comm,'Y','N')
from emp
group by nvl2(comm,'Y','N');

