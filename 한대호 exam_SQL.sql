set SERVEROUTPUT on;
---------------------------------------------------------------------------------------------------
-- EX 5.
-- (1) �̸��� SCOTT �� ����� �̸��� �μ� ��ġ�� ����ϴ� SQL �ۼ�.
select e.ename, d.loc 
from emp e, dept d 
where e.deptno=d.deptno and e.ename like upper('scott');

-- (2) �̸��� prompt�� �����, �ش����� �μ� ��ġ�� ����ϴ� PL/SQL �ۼ�. 
-- ��, �̸��� �ҹ��ڷ� �Է��ص� ����ǰ� �ۼ�.
ACCEPT x PROMPT '�̸�?';
declare
    x_ename varchar2(20) := upper('&x');
    v_ename varchar2(20);
    v_loc varchar2(20);
begin
    select e.ename, d.loc into v_ename, v_loc
    from emp e, dept d where e.deptno=d.deptno and e.ename = x_ename;  
    DBMS_OUTPUT.put_line(x_ename || '�� ' || v_loc || '���� �ٹ��մϴ�.');
end;
/
---------------------------------------------------------------------------------------------------
-- EX 6.
-- (1) �� ����� �ټӳ���� �˾ƺ����� �մϴ�. �Ʒ��� ���� ��µǵ��� SQL�� �ۼ��ϼ���.
select empno, ename, hiredate, (extract(year from sysdate) - extract(year from hiredate)) as year
from emp;

-- (2) �μ��� ���� ���� �Ի� ��¥�� ����ϴ� SQL�� �ۼ�
select deptno, max(hiredate) as MIN_HIREDATE 
from emp 
group by deptno 
order by deptno;

-- (3) 10�� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� SQL�� �ۼ�
select deptno, empno, ename, (extract(year from sysdate) - extract(year from hiredate)) as year
from emp 
where deptno = 10 and hiredate = (select min(hiredate) 
                                                from emp 
                                                where deptno=10);
                                                
-- (4) �� �μ����� �Ի� ��¥�� ���� ���� ������ �μ� ��ȣ, ���, �̸�, �ټӳ���� ����ϴ� PL/SQL�� �ۼ�
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
        dbms_output.put_line('�μ���ȣ : ' || r.deptno || ', ��� : ' || r.empno || ', �̸� : ' || r.ename || ', �ټӳ�� : ' || r.year);
    end loop;
end;
/
---------------------------------------------------------------------------------------------------
-- EX 7
-- (1) ���� �̸��� �� ������ �Ŵ��� �̸��� ����ϴ� SQL �ۼ�. ��, �Ŵ����� ���� ������ ����ؾ� ��.
select e1.ename, e2.ename 
from emp e1, emp e2
where e1.mgr = e2.empno(+);

--(2) SCOTT�� �Ŵ��� �̸��� ����ϴ� SQL �ۼ�.
select ename 
from emp
where empno = (select mgr 
                        from emp 
                        where ename = 'SCOTT');

-- (3) ���� �̸��� �Ķ���Ϳ� �����ϸ� �Ŵ����� �̸��� �����ϴ� �Լ��� �ۼ��ϰ� ����� Ȯ��.
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
-- (1) �Ŵ����� ������� �̸��� ����ϴ� SQL �ۼ�
select ename 
from emp 
where empno in (select distinct mgr 
                        from emp);

-- (2) �Ŵ����� �ƴ� ������� �̸��� ����ϴ� SQL �ۼ�
select ename 
from emp 
where empno not in (select distinct mgr 
                        from emp
                        where mgr is not null);

-- (3) ����� �Ķ���Ϳ� �����ϸ�, 
-- �� ����� �Ŵ����̸� 'm', �Ŵ����� �ƴϸ� 'e'�� �����ϴ� �Լ��� �ۼ��ϰ� �� ����� Ȯ��.
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

-- (4) ������ ���� �Լ��� ����ؼ� �Ʒ��� ���� ����� ��µǵ��� PL/SQL �ۼ�
declare
    cursor my_cursor is select empno, ename from emp;
begin
    for i in my_cursor loop
        if my_emp(i.empno) = 'm' then
            dbms_output.put_line(i.ename || '  �Ŵ���');
        else
            dbms_output.put_line(i.ename || '  ���');
        end if;
    end loop;
end;
/
---------------------------------------------------------------------------------------------------
-- EX 9.
-- (1) ���, �̸�, �Ի���, �Ŵ��� �̸�, �Ŵ��� �Ի����� ����ϴ� SQL �ۼ�. ��, �Ŵ������� ���� �Ի��� �����鸸 ���.
select e1.empno, e1.ename, e1.hiredate, e2.ename as mgr, e2.hiredate as mgr_hiredate
from emp e1, emp e2 where e1.mgr = e2.empno(+) and e1.hiredate < e2.hiredate;

-- (2) 7369 ����� �ڱ� �Ŵ������� ���� �Ի��ߴ� �� �ƴ��� Ȯ���ϴ� SQL �ۼ�.
-- 7839 ����� �ڱ� �Ŵ������� ���� �Ի��ߴ��� �ƴ��� Ȯ���ϴ� SQL �ۼ�.
select e1.empno, e1.hiredate, e2.hiredate as mgr_hiredate
from emp e1, emp e2
where e1.mgr = e2.empno(+) and e1.empno = 7369;

select e1.empno, e1.hiredate, e2.hiredate as mgr_hiredate
from emp e1, emp e2
where e1.mgr = e2.empno(+) and e1.empno = 7839;

-- (3) ����� �Ķ���Ϳ� �����ؼ�, �����ں��� ���� �Ի��� ������ 1, �׷��� ���� ������ 0�� �����ϴ� �Լ��� �ۼ�
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

-- (4) ������ �ۼ��� �Լ��� ����Ͽ� �Ʒ��� ���� ����� ��µǵ��� PL/SQL �ۼ�
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
-- �Ʒ��� ���� ���� ����� �ǵ��� ���ν����� �ۼ��ϰ�, PL/SQL�� �ۼ��ؼ� ����� Ȯ��.
create or replace procedure my_job 
is
    cursor my_sal (v_job varchar2) is select ename, sal from emp where job = v_job;
    cursor my_sal_total is select job, sum(sal) as TOTAL from emp group by job order by job;
begin
    for i in my_sal_total loop
        dbms_output.put_line('���� : ' || i.job);
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