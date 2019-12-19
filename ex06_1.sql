--no.1
select empno, substr(empno, 1 ,2) || rpad('*',2,'*') as mask_no, 
         ename, substr(ename, 1 ,1) || rpad('*',length(ename)-1,'*') as mask_name
from emp
where length(ename) >= 5;
--no.2
select empno,ename,sal, trunc(sal/21.5,3) as day_pay, round((sal/21.5)/8,2) as time_pay
from emp;
--no.3
SELECT empno, ename, hiredate, next_day(ADD_MONTHS(hiredate,3),'¿ù¿äÀÏ') as regular
from emp;