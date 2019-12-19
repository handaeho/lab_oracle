-- ������ �Լ�(multi-row function, group function)
-- �������� ���� �Լ��� argument�� ���޵Ǽ� �ϳ��� ������� ��µǴ� �Լ�

-- ��� ����� �޿��� �� �հ�, ���, �ִ�, �ּڰ�, �л�, ǥ������
select sum(sal), round(avg(sal), 2), max(sal), min(sal), 
        variance(sal), stddev(sal)
from emp;

-- count(����): �������� ������ ����
select count(*) from emp;
select count(empno) from emp;
select count(mgr) from emp;  -- count �Լ��� null�� �ƴ� ������ ������ ����
select count(deptno), count(distinct deptno) from emp;
-- count(distinct ����): �ߺ����� �ʴ� ������ ������ ����

-- (����) ���� ���� ����� ��µǴ� ������ �׷� �Լ��� �Բ� select�� �� ����!
select empno, count(empno) from emp;  -- ���� �߻� 


-- max(), min() �Լ��� date Ÿ�Կ��� ����� �� ����.
select max(hiredate), min(hiredate) from emp;

-- order by ����(�÷�)�̸� ���Ĺ��
-- ���� ���: ��������(asc), ��������(desc)
-- �������� ������ �⺻���̹Ƿ� asc�� ���� ����
select * from emp order by empno desc;
-- �μ���ȣ �������� ����
select * from emp order by deptno;

select * from emp order by deptno asc, empno desc;

-- 30�� �μ� ������� �޿��� �հ�, �ּڰ�, �ִ�, ���, �л�, ǥ������ ���
select 30 as DEPTNO,
        sum(sal) as SUM,
        min(sal) as MIN,
        max(sal) as MAX,
        round(avg(sal), 2) as AVG,
        round(variance(sal), 2) as VAR,
        round(stddev(sal), 2) as STDDEV
from emp
where deptno = 30;

select 10 as DEPTNO,
        sum(sal) as SUM,
        min(sal) as MIN,
        max(sal) as MAX,
        round(avg(sal), 2) as AVG,
        round(variance(sal), 2) as VAR,
        round(stddev(sal), 2) as STDDEV
from emp
where deptno = 10;

select 20 as DEPTNO,
        sum(sal) as SUM,
        min(sal) as MIN,
        max(sal) as MAX,
        round(avg(sal), 2) as AVG,
        round(variance(sal), 2) as VAR,
        round(stddev(sal), 2) as STDDEV
from emp
where deptno = 20;

-- �μ��� �޿��� �ּ�/�ִ�/��հ��� ���
select 10 as DEPTNO, min(sal), max(sal), avg(sal) from emp where deptno = 10
union
select 20 as DEPTNO, min(sal), max(sal), avg(sal) from emp where deptno = 30
union
select 30 as DEPTNO, min(sal), max(sal), avg(sal) from emp where deptno = 30;


-- ��� �׷� �Լ��� �⺻������ null�� �����ϰ� ����� ����
select sum(comm), avg(comm), avg(nvl(comm, 0)) 
from emp;


-- group by�� ����� ����
select deptno, avg(sal)
from emp
group by deptno
order by deptno;

-- ��å�� �޿� ���, �ּڰ�, �ִ�
select job, avg(sal), min(sal), max(sal)
from emp
group by job;

-- �Ŵ����� �޿� ���
select mgr, avg(sal) 
from emp
group by mgr;

select ename, deptno, avg(sal)
from emp
group by detpno; -- ���� �߻�
-- group by���� ������ ���� ����(�÷�)�� select�� �� ����!


-- �μ��� �޿� ��� ���. ��, ��� �޿��� 2000 �̻��� �μ��� ���.
select deptno, avg(sal)
from emp
where avg(sal) >= 2000
group by deptno; -- ���� �߻�
-- �׷� �Լ��� where ������ ����� �� ����!

select deptno, avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;

-- �Ŵ����� null�� �ƴ� ������ �߿���, �Ŵ��� ���� ��� �޿� ���
select mgr, avg(sal)
from emp
where mgr is not null
group by mgr;


-- �μ���, ��å�� ��� �޿�
select deptno, job, avg(sal)
from emp
group by deptno, job
order by deptno, job;

select deptno, job, avg(sal)
from emp
group by job, deptno
order by job, deptno;


-- 1) �μ���ȣ, �μ��� ��� �޿�, �μ��� �ְ�/�ּ� �޿�, ������� ���
-- �μ���ȣ ������������ ���. �Ҽ����� �ݿø��ؼ� ���ڸ������� ���
select deptno, round(avg(sal), 1) as AVG,
        max(sal) as MAX, min(sal) as MIN,
        count(*) as CNT
from emp
group by deptno
order by deptno;

-- 2) ���� ��å�� ���� ������� 3�� �̻��� ��å�� ���ؼ�, ��å�� ������� ���
select job, count(*) as CNT
from emp
group by job
having count(*) >= 3
order by CNT;
-- select���� ���� �÷��� ����(alias)�� 
-- group by �Ǵ� having �������� ����� �� ����!

-- 3) �Ի� ������ �޿� ���, �޿� �ּ�/�ִ��� ���. �Ի翬���� 'YYYY' �������� ���.
select to_char(hiredate, 'YYYY') as H_YEAR
from emp
group by to_char(hiredate, 'YYYY');

-- 4) �Ի� ������, �μ����� ����� �Ի��ߴ� ���� ���

-- 5) ����(comm)�� �޴� �������� ���� �ʴ� �������� ���




