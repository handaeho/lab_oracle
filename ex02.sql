--Alt + F10 = Make new worksheet

select empno,ename,sal as ����, sal*12 as ����  from emp;

select empno,ename,sal,comm from emp where comm is not null;

select empno,ename,sal,comm from emp where job = 'SALESMAN';

select empno,ename,sal,comm,(sal*12)+comm as �ѿ��� from emp where comm is not null;

select distinct job,deptno from emp order by deptno;



