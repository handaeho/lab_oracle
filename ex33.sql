/*
Ŀ��(cursor): PL/SQL ���ο��� SQL ������ ó���ϴ� ������ ������ �޸� ����
(1) ������ Ŀ��(explicit cursor): �����ڰ� ���� �̸��� �����ϰ� ����ϴ� Ŀ��
(2) ������ Ŀ��(implicit cursor): ���ٸ� ���� ���� ����ϴ� Ŀ��

������ Ŀ��: ���� -> open -> fetch -> close

*/

set serveroutput on;

select * from dept;

declare
    v_dept dept%rowtype;
begin 
    select * into v_dept from dept where deptno = 10;
    -- ����Ŭ DB ���ο��� ������ Ŀ���� �ڵ����� ������.
    dbms_output.put_line(v_dept.deptno);
end;
/


-- select into ������ 1�� �̻��� ��(row)�� select�Ǵ� ���� ����� �� ����.
-- ������ Ŀ���� select�� ��� ���� ������ ������� ����� �� �ִ�.
declare
    -- ������ Ŀ�� ����:
    -- cursor Ŀ���̸� is (SQL ����);
    cursor my_cursor is (
        select * from dept where deptno = 10
    );
    
    v_row dept%rowtype;  -- Ŀ���� �����͸� ����(fetch)�� �� ����� ����
begin
    -- Ŀ�� open(����, SQL ���� ����)
    open my_cursor;
    
    -- Ŀ�� fetch(������ �б�)
    fetch my_cursor into v_row;
    dbms_output.put_line(v_row.deptno || ', ' ||
                        v_row.dname || ', ' ||
                        v_row.loc);
    
    -- Ŀ�� close(�ݱ�)
    close my_cursor;
end;
/


-- ��� ���� 1���� ������ Ŀ��
declare
    -- (1) Ŀ�� ����
    cursor sel_emp is (
        select * from emp where empno = 7788
    );
    v_row emp%rowtype;  -- Ŀ�� ����� ����(fetch)�� ����
begin
    -- (2) Ŀ�� open
    open sel_emp;
    
    -- (3) Ŀ�� ���� ��� �б�(fetch)
    fetch sel_emp into v_row;
    dbms_output.put_line(v_row.empno || ', ' || v_row.ename);
    
    -- (4) Ŀ�� close
    close sel_emp;
end;
/

-- ��� ���� �������� �� �� �ִ� ������ Ŀ��
declare
    -- ������ Ŀ�� ����
    cursor sel_dept is (
        select * from dept
    );
    -- Ŀ�� ���� ����� fetch�� �� ����� ����
    v_row dept%rowtype;
begin
    -- (2) open
    open sel_dept;
    
    -- (3) fetch -- ��� ���� �������� ��� �ݺ��� �ȿ��� fetch
    loop
        fetch sel_dept into v_row;
        -- Ŀ������ ���̻� ���� ���ڵ尡 ���� �� loop�� ����
        exit when sel_dept%notfound;
        
        dbms_output.put_line(v_row.deptno || ', ' 
                        || v_row.dname || ', ' 
                        || v_row.loc);
    end loop;
    
    -- (4) close
    close sel_dept;
end;
/


-- emp ���̺����� �μ���ȣ�� 30���� �������� ���, �̸�, �޿��� ��� 
declare
    cursor sel_emp is (
        select * from emp where deptno = 30
    );

    v_row emp%rowtype;
begin
    open sel_emp;
    
    loop
        fetch sel_emp into v_row;
        exit when sel_emp%notfound;
        dbms_output.put_line(v_row.empno || ', ' 
                        || v_row.ename || ', '
                        || v_row.sal);
    end loop;
    
    close sel_emp;
end;
/


declare
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10
    );
    type my_record is record (
        empno   emp.empno%type,
        ename   emp.ename%type,
        sal     emp.sal%type
    );
    v_row my_record;
begin
    open my_cursor;
    
--    loop 
--        fetch my_cursor into v_row;
--        exit when my_cursor%notfound;
--    end loop;

    fetch my_cursor into v_row;
    while my_cursor%found loop
        dbms_output.put_line(v_row.empno || ', ' 
                        || v_row.ename || ', '
                        || v_row.sal);
        fetch my_cursor into v_row;
    end loop;
    
    close my_cursor;
end;
/


-- ������ Ŀ���� for loop���� ���
-- open, fetch, close�� �ڵ����� �����
-- for ���� in Ŀ�� loop ... end loop;
declare
    cursor my_cursor is (
        select * from dept
    );
begin
    for row in my_cursor loop
        dbms_output.put_line(row.deptno || ', ' || row.dname || ', ' || row.loc);
    end loop;
end;
/

-- ������ Ŀ��, for loop�� ����ؼ� 
-- 20�� �μ��� �������� ���, �̸�, �޿��� ��� 
declare
    cursor my_cursor is (
        select empno, ename name, sal from emp where deptno = 20
    );
begin
    for row in my_cursor loop
        dbms_output.put_line(row.empno || ', ' || row.name || ', ' || row.sal);
    end loop;
end;
/

-- ��ü ������ �޿� ��պ��� ���� �޿��� �޴� �������� �̸��� ����ϴ� PL/SQL
select avg(sal) from emp;
select ename from emp where sal < ?;
select ename from emp where sal < (select avg(sal) from emp);

declare
    cursor my_cursor is (
        select ename from emp
        where sal < (
            select avg(sal) from emp
        )
    );
begin
    for result in my_cursor loop
        dbms_output.put_line(result.ename);
    end loop;
end;
/

--  �Ķ����(parameter, �Ű�����)�� ���� Ŀ�� ����
-- cursor Ŀ���̸�(���� Ÿ��, ���� Ÿ��, ...) is SQL����;
declare
    v_avg number;
    cursor my_cursor(p_avg number) is
        select ename from emp where sal < p_avg;
begin
    -- ��ü ������ �޿� ����� �˾Ƴ�
    select avg(sal) into v_avg from emp;
    dbms_output.put_line(v_avg);
    
    -- �Ķ���͸� ���� Ŀ���� open/fetch/close
    for row in my_cursor(v_avg) loop
        dbms_output.put_line(row.ename);
    end loop;
end;
/


-- 10�� �μ�����, 10�� �μ� �������� �޿� ��պ��� ���� �޿��� �޴� �������� 
-- �̸��� ����ϴ� PL/SQL
select deptno, ename from emp
where sal < (
    select avg(sal) from emp where deptno = 10
) and deptno = 10;

declare
    cursor my_cursor is
        select deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = 10)
        and
        deptno = 10;
begin
    for row in my_cursor loop
        dbms_output.put_line(row.deptno || ', ' || row.ename);
    end loop;
end;
/

declare
    cursor my_cursor(p_deptno emp.deptno%type) is
        select deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = p_deptno)
        and deptno = p_deptno;
begin
    for row in my_cursor(20) loop
        dbms_output.put_line(row.deptno || ', ' || row.ename);
    end loop;
end;
/

-- �� �μ�����, �� �μ� �������� �޿� ��պ��� ���� �޿��� �޴� �������� 
-- �μ���ȣ�� ���� �̸��� ����ϴ� PL/SQL
declare
    cursor get_deptno is 
        select deptno from dept;
    cursor my_cursor(p_deptno emp.deptno%type) is 
        select deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = p_deptno)
        and deptno = p_deptno;
begin
    for rslt in get_deptno loop
--        dbms_output.put_line(rslt.deptno);
        for row in my_cursor(rslt.deptno) loop
            dbms_output.put_line(row.deptno || ', ' || row.ename);
        end loop;
    end loop;
end;
/

select deptno from dept;
select deptno from emp;
select distinct deptno from emp;

select deptno, avg(sal) from emp group by deptno;

declare
    cursor cur1 is
        select deptno, avg(sal) average from emp
        group by deptno
        order by deptno;
    cursor cur2(p_deptno emp.deptno%type, p_avg number) is
        select deptno, ename, sal from emp
        where deptno = p_deptno and sal < p_avg;
begin
    for r1 in cur1 loop
        dbms_output.put_line(r1.deptno || ', ' || r1.average);
        for r2 in cur2(r1.deptno, r1.average) loop
            dbms_output.put_line(r2.deptno || ', ' || r2.ename || ', ' || r2.sal);
        end loop;
    end loop;
end;
/


select deptno dno, avg(sal) average from emp 
group by deptno;

select a.dno
from (select deptno dno, avg(sal) average from emp group by deptno) a;

select e.deptno, e.ename, e.sal, a.average
from emp e
    join (select deptno, avg(sal) average 
            from emp group by deptno) a
    on e.deptno = a.deptno
where e.sal < a.average
order by e.deptno;
    
declare
    cursor my_cursor is
        select e.deptno, e.ename, e.sal, a.average
        from emp e
            join (select deptno, avg(sal) average 
                    from emp group by deptno) a
            on e.deptno = a.deptno
        where e.sal < a.average
        order by e.deptno;
begin
    for r in my_cursor loop
        
    end loop;
end;
/
    
    
    
    