set SERVEROUTPUT on;
---------------------------------------------------------------------------------------------------
-- EX 5.
-- (1) 이름이 SCOTT 인 사원의 이름과 부서 위치를 출력하는 SQL 작성.
select e.ename, d.loc 
from emp e, dept d 
where e.deptno=d.deptno and e.ename like upper('scott');

-- (2) 이름을 prompt로 물어보고, 해당사원의 부서 위치를 출력하는 PL/SQL 작성. 
-- 단, 이름은 소문자로 입력해도 수행되게 작성.
ACCEPT x PROMPT '이름?';
declare
    x_ename varchar2(20) := upper('&x');
    v_ename varchar2(20);
    v_loc varchar2(20);
begin
    select e.ename, d.loc into v_ename, v_loc
    from emp e, dept d where e.deptno=d.deptno and e.ename = x_ename;  
    DBMS_OUTPUT.put_line(x_ename || '은 ' || v_loc || '에서 근무합니다.');
end;
/
---------------------------------------------------------------------------------------------------
-- EX 6.
-- (1) 각 사원의 근속년수를 알아보고자 합니다. 아래와 같이 출력되도록 SQL을 작성하세요.
select empno, ename, hiredate, (extract(year from sysdate) - extract(year from hiredate)) as year
from emp;

-- (2) 부서별 가장 빠른 입사 날짜를 출력하는 SQL을 작성
select deptno, max(hiredate) as MIN_HIREDATE 
from emp 
group by deptno 
order by deptno;

-- (3) 10번 부서에서 입사 날짜가 가장 빠른 직원의 부서 번호, 사번, 이름, 근속년수를 출력하는 SQL을 작성
select deptno, empno, ename, (extract(year from sysdate) - extract(year from hiredate)) as year
from emp 
where deptno = 10 and hiredate = (select min(hiredate) 
                                                from emp 
                                                where deptno=10);
                                                
-- (4) 각 부서에서 입사 날짜가 가장 빠른 직원의 부서 번호, 사번, 이름, 근속년수를 출력하는 PL/SQL을 작성
select deptno, empno, ename, trunc(months_between(sysdate, hiredate)/12, 0) as year 
from emp
where hiredate in (select min(hiredate) 
                            from emp group by deptno) 
order by deptno;
        
declare cursor faster_emp is (
    select deptno, empno, ename, trunc(months_between(sysdate, hiredate)/12, 0) as year 
    from emp
    where hiredate in (select min(hiredate) from emp group by deptno)) 
    order by deptno;
begin
    for r in faster_emp loop
        dbms_output.put_line('부서번호 : ' || r.deptno || ', 사번 : ' || r.empno || ', 이름 : ' || r.ename || ', 근속년수 : ' || r.year);
    end loop;
end;
/
---------------------------------------------------------------------------------------------------
-- EX 7
-- (1) 직원 이름과 그 직원의 매니저 이름을 출력하는 SQL 작성. 단, 매니저가 없는 직원도 출력해야 함.
select e1.ename, e2.ename 
from emp e1, emp e2
where e1.mgr = e2.empno(+);

--(2) SCOTT의 매니저 이름을 출력하는 SQL 작성.
select ename 
from emp
where empno = (select mgr 
                        from emp 
                        where ename = 'SCOTT');

-- (3) 직원 이름을 파라미터에 전달하면 매니저의 이름을 리턴하는 함수를 작성하고 결과를 확인.
set serveroutput on;
   
create or replace function my_mgr (e_name varchar2) return varchar2
is 
    v_mgr emp.ename%type;
begin
    select e2.ename into v_mgr
    from emp e1, emp e2 
    where e1.mgr = e2.empno(+) and upper(e1.ename) = upper(e_name);
    return v_mgr;
end;
/
        
select my_mgr('scott') from dual;
select my_mgr('king') from dual;
select my_mgr('ford') from dual; 
---------------------------------------------------------------------------------------------------
-- EX 8
-- (1) 매니저인 사원들의 이름을 출력하는 SQL 작성
select ename 
from emp 
where empno in (select distinct mgr 
                        from emp);

-- (2) 매니저가 아닌 사원들의 이름을 출력하는 SQL 작성
select ename 
from emp 
where empno not in (select distinct mgr 
                        from emp
                        where mgr is not null);

-- (3) 사번을 파라미터에 전달하면, 
-- 그 사원이 매니저이면 'm', 매니저가 아니면 'e'를 리턴하는 함수를 작성하고 그 결과를 확인.
create or replace function my_emp ( 
    v_empno emp.empno%type)
return varchar2
is
    cursor mgr_emp is select empno from emp where empno in (select distinct mgr from emp); 
begin
    for i in mgr_emp loop
            if v_empno = i.empno then
                return 'm';
            end if;
        end loop;
        return 'e';
end;
/

select my_emp(7788) from dual;

-- (4) 위에서 만든 함수를 사용해서 아래와 같이 결과가 출력되도록 PL/SQL 작성
declare
    cursor my_cursor is select empno, ename from emp;
begin
    for i in my_cursor loop
        if my_emp(i.empno) = 'm' then
            dbms_output.put_line(i.ename || '  매니저');
        else
            dbms_output.put_line(i.ename || '  사원');
        end if;
    end loop;
end;
/
---------------------------------------------------------------------------------------------------
-- EX 9.
-- (1) 사번, 이름, 입사일, 매니저 이름, 매니저 입사일을 출력하는 SQL 작성. 단, 매니저보다 먼저 입사한 직원들만 출력.
select e1.empno, e1.ename, e1.hiredate, e2.ename as mgr, e2.hiredate as mgr_hiredate
from emp e1, emp e2 where e1.mgr = e2.empno(+) and e1.hiredate < e2.hiredate;

-- (2) 7369 사원은 자기 매니저보다 먼저 입사했는 지 아닌지 확인하는 SQL 작성.
-- 7839 사원은 자기 매니저보다 먼저 입사했는지 아닌지 확인하는 SQL 작성.
select e1.empno, e1.hiredate, e2.hiredate as mgr_hiredate
from emp e1, emp e2
where e1.mgr = e2.empno(+) and e1.empno = 7369;

select e1.empno, e1.hiredate, e2.hiredate as mgr_hiredate
from emp e1, emp e2
where e1.mgr = e2.empno(+) and e1.empno = 7839;

-- (3) 사번을 파라미터에 전달해서, 관리자보다 먼저 입사한 직원은 1, 그렇지 않은 직원은 0을 리턴하는 함수를 작성
create or replace function my_emp2 ( 
    v_empno emp.empno%type)
return number
is
    v_hiredate date;
    v_mgr_hiredate date;
begin 
        select e1.hiredate, e2.hiredate as mgr_hiredate into v_hiredate, v_mgr_hiredate
        from emp e1, emp e2
        where e1.mgr = e2.empno(+) and e1.empno = v_empno; 
        
        if v_mgr_hiredate > v_hiredate then
            return 1;
        else
            return 0;
        end if;
end;
/

select my_emp2(7839) from dual;

-- (4) 위에서 작성한 함수를 사용하여 아래와 같이 결과가 출력되도록 PL/SQL 작성
declare
    cursor my_hiredate is select ename, hiredate, empno from emp;
begin 
    for i in my_hiredate loop
        dbms_output.put_line(i.ename || '  ' || to_char(i.hiredate, 'YYYY/MM/DD') || '  ' || my_emp2(i.empno));
    end loop;
end;
/
---------------------------------------------------------------------------------------------------
-- EX 10.
-- 아래와 같은 보고서 출력이 되도록 프로시저를 작성하고, PL/SQL을 작성해서 결과를 확인.
create or replace procedure my_job 
is
    cursor my_sal (v_job varchar2) is select ename, sal from emp where job = v_job;
    cursor my_sal_total is select job, sum(sal) as TOTAL from emp group by job order by job;
begin
    for i in my_sal_total loop
        dbms_output.put_line('직업 : ' || i.job);
        for j in my_sal(i.job) loop
            dbms_output.put_line(j.ename || ' / ' || j.sal || ' / ' ||  i.job);       
        end loop;
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line('TOTAL : ' || i.total);
        dbms_output.put_line(' ');
    end loop;
end;
/

begin
        my_job;
    end;
    /