-- JOIN
select *
from emp, dept;

-- ����Ŭ ��� cross join(īƼ�� ���δ�Ʈ)
select *
from emp, dept;

--ǥ�ع��(ANSI) cross join
select *
from emp cross join dept;
------------------------------------------------------------------------------------
--����Ŭ ��� ����
select *
from emp e, dept d
where e.deptno = d.deptno
order by empno;

--ǥ�� ��� ����
select *
from emp join dept
on emp.deptno = dept.deptno
order by empno;
------------------------------------------------------------------------------------
--����Ŭ ���
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;
-- ǥ�� ���
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
-- ����Ŭ ���
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.sal >= 2000;
-- ǥ�� ���
select e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 2000;
------------------------------------------------------------------------------------
-- ����Ŭ ��� (non-equal join, ���ϱ�)
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal BETWEEN s.losal and s.hisal;
-- ǥ�ع��
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal;
------------------------------------------------------------------------------------
--����Ŭ ���(3�� ���̺� ����)
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno 
        and e.sal between s.losal and s.hisal; 
-- ǥ�ع��
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e join dept d
on e.deptno = d.deptno
join salgrade s
on e.sal between s.losal and s.hisal;
------------------------------------------------------------------------------------
-- ����Ŭ ���(Self - join)
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename 
from emp e1, emp e2
where e1.mgr = e2.empno;
--ǥ�ع��
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 join emp e2
on e1.mgr = e2.empno;
------------------------------------------------------------------------------------
-- ����Ŭ ���(Outer - join -- Right join 1)
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno (+)= d.deptno;
-- ǥ�ع��
select e.empno, e.ename, e.deptno, d.dname
from emp e right join dept d
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
-- ����Ŭ ���(Outer - join -- Right join 2 = left join 1, dept�� �����ʿ�)
select e.empno, e.ename, e.deptno, d.dname
from dept d,  emp e
where d.deptno (+)= e.deptno;
-- ǥ�ع��
select e.empno, e.ename, e.deptno, d.dname
from dept d right join emp e
on d.deptno = e.deptno;
------------------------------------------------------------------------------------
-- ����Ŭ ���(Outer - join -- left join 1)
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+);
-- ǥ�ع��
select e.empno, e.ename, e.deptno, d.dname
from emp e left join dept d
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
-- ����Ŭ ���(Outer - join -- left join 2 = right join 1, dept�� �����ʿ�)
select e.empno, e.ename, e.deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+);
-- ǥ�ع��
select e.empno, e.ename, e.deptno, d.dname
from dept d left join emp e
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno; --KING �� ����

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+); --KING ������ (�Ŵ��� ��� ����)

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 left join emp e2
on e1.mgr = e2.empno; --KING ������ (�Ŵ��� ��� ����)
------------------------------------------------------------------------------------
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno; -- (�������� ���) ��� ��� �̸� ������

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 right join emp e2
on e1.mgr = e2.empno; -- (�������� ���) ��� ��� �̸� ������
------------------------------------------------------------------------------------
-- Full Outer Join (Outer�� ���� ����, oracle ��Ŀ����� full join�� ����. Union ���)
select e1.empno, e1.ename, e2.empno, e2.ename
from emp e1 full outer join emp e2
on e1.mgr = e2.empno;

------------------------------------------------------------------------------------
--EX 1
select e.deptno, d.dname, round(avg(e.sal),1) avg , max(e.sal) max, count(e.empno) cnt
from emp e, dept d
where e.deptno = d.deptno 
group by e.deptno, d.dname;

--EX2
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from emp e, dept d
where e.deptno (+)= d.deptno
order by e.deptno;

--EX3 (ǥ�� ���)
select d.deptno, d.dname, 
        e1.empno, e1.ename, e1.mgr, e1.sal, 
        e2.empno mgr_no, e2.ename mgr_name, 
        s.grade
from dept d 
    left join emp e1
        on d.deptno = e1.deptno
    left join emp e2
        on e1.mgr= e2.empno
    left join salgrade s           
        on e1.sal between s.losal and s.hisal
order by deptno;

-- OR (����Ŭ ���)
select d.deptno, d.dname, 
        e1.empno, e1.ename, e1.mgr, e1.sal, 
        e2.empno mgr_no, e2.ename mgr_name, 
        s.grade
from dept d, emp e1, emp e2, salgrade s
where d.deptno = e1.deptno(+)
            and e1.mgr = e2.empno(+)
            and e1.sal between s.losal(+) and s.hisal(+)
order by deptno;
------------------------------------------------------------------------------------
