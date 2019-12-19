-- join

-- Oracle ����� Cross Join(Cartesian Product)
select *
from emp, dept;

-- ANSI(ǥ��) ����� Cross Join
select *
from emp cross join dept;

-- Oracle ����� Join
select *
from emp, dept
where emp.deptno = dept.deptno
order by emp.empno;

-- ANSI ����� Join
select *
from emp e join dept d
    on e.deptno = d.deptno
order by e.empno;

-- emp ���̺�� dept ���̺���
-- ���, �̸�, �μ���ȣ, �μ��̸��� ���
-- 1) Oracle ���
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno
order by e.empno;
-- 2) ANSI ���
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
    on e.deptno = d.deptno
order by e.empno;

-- emp ���̺�� dept ���̺���
-- ���, �̸�, �޿�, �μ���ȣ, �μ��̸��� �˻�
-- ��, �޿��� 2000 �̻��� ������ ����
-- 1) Oracle ���
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
      and
      e.sal >= 2000;
-- 2) ANSI ���
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e join dept d
    on e.deptno = d.deptno
where e.sal >= 2000;


-- emp ���̺�� salgrade ���̺���
-- ���, �̸�, �޿�, �޿� ����� ���
-- 1) Oracel
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal;
-- 2) ANSI
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
           on e.sal >= s.losal and e.sal <= s.hisal;
           -- on e.sal between s.losal and s.hisal;


-- emp, dept, salgrade ���̺���
-- ���, �̸�, �μ���ȣ, �μ��̸�, �޿�, �޿� ����� ���
-- 1) Oracle
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
      and
      e.sal between s.losal and s.hisal;
-- 2) ANSI
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e join dept d
           on e.deptno = d.deptno
     join salgrade s
           on e.sal between s.losal and s.hisal;

           
-- emp ���̺��� ���, �̸�, �Ŵ��� ���, �Ŵ��� �̸� ���
-- 1) Oracle
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;
-- 2) ANSI
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 join emp e2
     on e1.mgr = e2.empno;


-- emp, dept���̺��� ���, �̸�, �μ���ȣ, �μ��̸��� ���
-- dept ���̺��� ��� �μ� ������ ���
-- 1) Oracle
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;
-- 2) ANSI
select e.empno, e.ename, d.deptno, d.dname
from emp e right join dept d
    on e.deptno = d.deptno;
    
select e.empno, e.ename, d.deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+);

select e.empno, e.ename, d.deptno, d.dname
from dept d left join emp e
    on d.deptno = e.deptno;


-- emp ���̺��� ���, �̸�, �Ŵ��� ���, �Ŵ��� �̸� ���
-- �Ŵ����� �������� �ʴ� King�� ������ �Բ� ���
-- 1) Oracle
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+);
-- 2) ANSI
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 left join emp e2
    on e1.mgr = e2.empno;

-- ���� ������ ���� ������� ������ �Բ� ���(21 records)
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno;

select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 right join emp e2
    on e1.mgr = e2.empno;


-- full (outer) join
-- full join�� ANSI ����� ������ �ְ�, Oracle ����� ������ ����
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 full join emp e2
    on e1.mgr = e2.empno;
-- Oracle ������� full join�� �Ϸ��� UNION(������) �����ڸ� ����ؾ� ��
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2 where e1.mgr = e2.empno(+)
union
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1, emp e2 where e1.mgr(+) = e2.empno;


-- Ex 1.
select e.deptno, dname, round(avg(sal), 1), max(sal), min(sal), count(*)
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, dname;

select e.deptno, dname, round(avg(sal), 1), max(sal), min(sal), count(*)
from emp e join dept d
    on e.deptno = d.deptno
group by e.deptno, dname;


-- Ex 2
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e
where d.deptno = e.deptno(+);

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left join emp e
    on d.deptno = e.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e, dept d
where e.deptno(+) = d.deptno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e right join dept d
    on d.deptno = e.deptno;

-- ex3
select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr, 
       e2.ename as mgr_name,
       e1.sal,
       s.grade
from dept d, emp e1, emp e2, salgrade s
where d.deptno = e1.deptno(+)
      and
      e1.mgr = e2.empno(+)
      and
      e1.sal between s.losal(+) and s.hisal(+);

select d.deptno, d.dname, e1.empno, e1.ename, e1.mgr,
       e2.ename as mgr_name,
       e1.sal, s.grade
from dept d left join emp e1
            on d.deptno = e1.deptno
            left join emp e2
            on e1.mgr = e2.empno
            left join salgrade s
            on e1.sal between s.losal and s.hisal;





