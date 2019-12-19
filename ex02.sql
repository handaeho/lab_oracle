--Alt + F10 = Make new worksheet

select empno,ename,sal as ¿ù±Þ, sal*12 as ¿¬ºÀ  from emp;

select empno,ename,sal,comm from emp where comm is not null;

select empno,ename,sal,comm from emp where job = 'SALESMAN';

select empno,ename,sal,comm,(sal*12)+comm as ÃÑ¿¬ºÀ from emp where comm is not null;

select distinct job,deptno from emp order by deptno;



