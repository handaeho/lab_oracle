/*
Ŀ��(Cursor) = PL/SQL���� SQL ���� ó�� ������ �����ϴ� �޸� ����.
1) ����� Ŀ��(Explicit cursor) : �����ڰ� ���� �̸��� �����ϰ� �����.
2) ������ Ŀ�� (Implicit cursor) : �� �ٸ� ���� ���� �����.

����� Ŀ���� ���� : ���� -> open -> fetch -> close
*/
--------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
--------------------------------------------------------------------------------------------------------------
select * from dept;

declare
    v_dept dept%rowtype;
begin
    select * into v_dept from dept where deptno =10;
    
-- ����Ŭ ���ο��� ������ Ŀ���� �ڵ����� ������.    
    DBMS_OUTPUT.put_line(v_dept.deptno); 
end;
/
--------------------------------------------------------------------------------------------------------------
--  select ~ into ~ ������ �� �� �̻��� row�� select�Ǵ� ���� ��� ��.
-- ����� Ŀ���� select�� ��� row�� ������ ������� ��� ����.
declare
-- ����� Ŀ�� ���� -> cusor Ŀ���̸� is (SQL ����);
    cursor my_cursor is (
        select * from dept where deptno =10);
        
    v_row dept%rowtype; -- Ŀ���� �����͸� fetch �� �� ����� ����
begin
-- Ŀ�� open(����, ����)
    open my_cursor;
    
-- Ŀ�� fetch(������ �м�)
    fetch my_cursor into v_row;
    
    DBMS_OUTPUT.PUT_LINE(v_row.deptno || ' / ' || v_row.dname || ' / ' || v_row.loc);
    
-- Ŀ�� close(�ݱ�)
    close my_cursor;
end;
/
--------------------------------------------------------------------------------------------------------------
-- ��� ���� 1���� ����� Ŀ��
declare
-- Ŀ�� ����
    cursor sel_emp is (
        select * from emp where empno = 7788);
        
        v_row emp%rowtype; -- Ŀ�� ��� fetch �� ����
begin
-- Ŀ�� open
    open sel_emp;

-- Ŀ�� fetch
    fetch sel_emp into v_row;
    DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename);
-- Ŀ�� close
    close sel_emp;
end;
/
--------------------------------------------------------------------------------------------------------------
-- ��� ���� �������� ����� Ŀ��
declare
-- Ŀ�� ����
    cursor sel_dept is (
        select * from dept);
        
        v_row dept%rowtype; -- Ŀ�� ��� fetch �� ����
begin
-- Ŀ�� open
    open sel_dept;

-- Ŀ�� fetch
-- ���� ���� ������ ���Ͻÿ��� loop ���.
    loop
        fetch sel_dept into v_row;
        -- Ŀ������ ���̻� ���� �����Ͱ� ������ ���� ����
        exit when sel_dept%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.deptno || ' / ' || v_row.dname || ' / ' || v_row.loc);
    end loop;

-- Ŀ�� close
    close sel_dept;
end;
/
--------------------------------------------------------------------------------------------------------------
-- emp ���̺��� �μ� ��ȣ�� 30���� �������� ���, �̸�, �޿��� ���
declare
-- Ŀ�� ����
    cursor ex_emp is (
        select * from emp where deptno = 30);
        
        v_row emp%rowtype; -- Ŀ�� ��� fetch �� ����
begin
-- Ŀ�� open
    open ex_emp;

-- Ŀ�� fetch
-- ���� ���� ������ ���Ͻÿ��� loop ���.
    loop
        fetch ex_emp into v_row;
        -- Ŀ������ ���̻� ���� �����Ͱ� ������ ���� ����
        exit when ex_emp%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal || ' / ' || v_row.deptno);
    end loop;

-- Ŀ�� close
    close ex_emp;
end;
/
--------------------------------------------------------------------------------------------------------------
declare
-- Ŀ�� ����
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10);
        
    type my_record is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type);
         
        v_row my_record; -- Ŀ�� ��� fetch �� ����
begin
-- Ŀ�� open
    open my_cursor;

-- Ŀ�� fetch
--    loop
--        fetch my_cursor into v_row;
--        -- Ŀ������ ���̻� ���� �����Ͱ� ������ ���� ����
--        exit when my_cursor%notfound;
--        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal);
--    end loop;

-- ���� loop���� while�� �ٲپ�����. �����͸� found �ߴٸ� �ݺ�
    fetch my_cursor into v_row;
    while my_cursor%found loop
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal);
        fetch my_cursor into v_row;
    end loop; -- fetch�� ���� �޸��� ���� �����͸� �о� �� ��, 
                    --found�� �����͸� ã��, ã�� �� �����͸� �ٽ� �޸𸮿� fetch.
                    -- ���� fetch���� while�� �տ� �ϳ�, �ȿ� �ϳ��� �ۼ��ؾ߸� �Ѵ�.

-- Ŀ�� close
    close my_cursor;
end;
/
--------------------------------------------------------------------------------------------------------------
-- ����� Ŀ���� for loop���� ����� ���� open / fetch / close ������ �ڵ����� �����. ���� �ʿ� X.
-- for ���� in Ŀ���̸� loop ~ end loop;
declare
-- Ŀ�� ����
    cursor my_cursor is (
        select * from dept);

begin
    for row in my_cursor loop
        DBMS_OUTPUT.PUT_LINE(row.deptno || ' / ' || row.dname || ' / ' || row.loc);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- ����� Ŀ�� & for loop�� ����� 20�� �μ��� ���� ���, �̸�, �޿� ���
declare
-- Ŀ�� ����
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 20);

begin
    for row in my_cursor loop
        DBMS_OUTPUT.PUT_LINE(row.empno || ' / ' || row.ename || ' / ' || row.sal || ' / ' || row.deptno);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- �Ķ����(�Ű�����)�� ���� Ŀ��
-- cursor Ŀ���̸�(���� Ÿ��) is SQL ����;
declare
    v_avg number;
    
    CURSOR my_cursor(p_avg number) is
        select ename from emp where sal < p_avg;
begin
-- ��ü ���� �޿� ��� ���ϱ�
    select avg(sal) into v_avg from emp;
    DBMS_OUTPUT.PUT_LINE(v_avg);
    
-- �Ķ���͸� ���� Ŀ���� open, fetch, close (for������ �� ����)
    for row in my_cursor(v_avg) loop
        DBMS_OUTPUT.PUT_LINE(row.ename);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 1) ��ü ������ �޿� ��պ��� ���� �޿��� ���� �̸� ���.
declare
    CURSOR ex1_emp is (
        select * from emp where sal < (select avg(sal) from emp)); 
        
         v_row emp%rowtype;
begin 
    open ex1_emp;
    
    loop
        fetch ex1_emp into v_row;
        exit when ex1_emp%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal || ' / ' || v_row.deptno);
    end loop;
    
    close ex1_emp;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 2) 10�� �μ����� 10�� �μ� �޿� ��պ��� ���� �޿� �޴� ���� �̸� ���.
declare
    CURSOR ex2_emp is (
        select * from emp where deptno = 10 and sal < (select avg(sal) from emp where deptno = 10)); 
        
         v_row emp%rowtype;
begin 
    open ex2_emp;
   
    loop
        fetch ex2_emp into v_row;
        exit when ex2_emp%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal || ' / ' || v_row.deptno);
    end loop;
    
    close ex2_emp;
end;
/
---------------------OR---------------------
declare
    cursor my_cursor is
        select deptno, ename from emp where deptno =10 and 
                                                                sal <(select avg(sal) from emp where deptno =10); 

begin
    for row in my_cursor loop
        DBMS_OUTPUT.PUT_LINE(row.ename || ' / ' ||row.deptno);
    end loop;
end;
/
---------------------OR---------------------
declare
    cursor my_cursor(p_deptno emp.deptno%type) is -- my_cursor(�μ���ȣ)
        SELECT deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = p_deptno) and deptno = p_deptno;
begin
    for row in my_cursor(10) loop -- ���⿡�� my_cursor(�μ���ȣ)
        DBMS_OUTPUT.PUT_LINE(row.ename || ' / ' ||row.deptno);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 3) �� �μ����� �� �μ��� �޿� ��պ��� ���� �޿� �޴� ���� �̸��� �μ���ȣ ���.
declare
    cursor my_cursor(p_deptno emp.deptno%type) is -- my_cursor(�μ���ȣ)
        SELECT deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = p_deptno) and deptno = p_deptno;
begin
    for i in 1..30 loop
        for row in my_cursor(i) loop -- ���⿡�� my_cursor(�μ���ȣ)
            DBMS_OUTPUT.PUT_LINE(row.ename || ' / ' ||row.deptno);
        end loop;
    end loop;
end;
/