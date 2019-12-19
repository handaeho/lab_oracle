-- JOIN
select *
from emp, dept;

-- 오라클 방식 cross join(카티션 프로덕트)
select *
from emp, dept;

--표준방식(ANSI) cross join
select *
from emp cross join dept;
------------------------------------------------------------------------------------
--오라클 방식 조인
select *
from emp e, dept d
where e.deptno = d.deptno
order by empno;

--표준 방식 조인
select *
from emp join dept
on emp.deptno = dept.deptno
order by empno;
------------------------------------------------------------------------------------
--오라클 방식
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;
-- 표준 방식
select e.empno, e.ename, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
-- 오라클 방식
select e.empno, e.ename, e.sal, d.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno and e.sal >= 2000;
-- 표준 방식
select e.empno, e.ename, e.sal, e.deptno, d.dname
from emp e join dept d
on e.deptno = d.deptno
where e.sal >= 2000;
------------------------------------------------------------------------------------
-- 오라클 방식 (non-equal join, 비교하기)
select e.empno, e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal BETWEEN s.losal and s.hisal;
-- 표준방식
select e.empno, e.ename, e.sal, s.grade
from emp e join salgrade s
on e.sal between s.losal and s.hisal;
------------------------------------------------------------------------------------
--오라클 방식(3개 테이블 조인)
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno 
        and e.sal between s.losal and s.hisal; 
-- 표준방식
select e.empno, e.ename, e.deptno, d.dname, e.sal, s.grade
from emp e join dept d
on e.deptno = d.deptno
join salgrade s
on e.sal between s.losal and s.hisal;
------------------------------------------------------------------------------------
-- 오라클 방식(Self - join)
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename 
from emp e1, emp e2
where e1.mgr = e2.empno;
--표준방식
select e1.empno, e1.ename, e1.mgr, e2.empno, e2.ename
from emp e1 join emp e2
on e1.mgr = e2.empno;
------------------------------------------------------------------------------------
-- 오라클 방식(Outer - join -- Right join 1)
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno (+)= d.deptno;
-- 표준방식
select e.empno, e.ename, e.deptno, d.dname
from emp e right join dept d
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
-- 오라클 방식(Outer - join -- Right join 2 = left join 1, dept가 오른쪽에)
select e.empno, e.ename, e.deptno, d.dname
from dept d,  emp e
where d.deptno (+)= e.deptno;
-- 표준방식
select e.empno, e.ename, e.deptno, d.dname
from dept d right join emp e
on d.deptno = e.deptno;
------------------------------------------------------------------------------------
-- 오라클 방식(Outer - join -- left join 1)
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno(+);
-- 표준방식
select e.empno, e.ename, e.deptno, d.dname
from emp e left join dept d
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
-- 오라클 방식(Outer - join -- left join 2 = right join 1, dept가 오른쪽에)
select e.empno, e.ename, e.deptno, d.dname
from dept d, emp e
where d.deptno = e.deptno(+);
-- 표준방식
select e.empno, e.ename, e.deptno, d.dname
from dept d left join emp e
on e.deptno = d.deptno;
------------------------------------------------------------------------------------
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno; --KING 안 나옴

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno(+); --KING 나오게 (매니저 없어도 나옴)

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 left join emp e2
on e1.mgr = e2.empno; --KING 나오게 (매니저 없어도 나옴)
------------------------------------------------------------------------------------
select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr = e2.empno;

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1, emp e2
where e1.mgr(+) = e2.empno; -- (부하직원 없어도) 모든 사원 이름 나오게

select e1.empno, e1.ename, e1.mgr, e2.ename
from emp e1 right join emp e2
on e1.mgr = e2.empno; -- (부하직원 없어도) 모든 사원 이름 나오게
------------------------------------------------------------------------------------
-- Full Outer Join (Outer는 생략 가능, oracle 방식에서는 full join이 없다. Union 사용)
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

--EX3 (표준 방식)
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

-- OR (오라클 방식)
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
