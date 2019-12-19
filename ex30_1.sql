-- ���ڵ� & �÷���
/*
���ڵ� : ������ Ÿ���� ���� �ٸ� �������� �����͸� ���� �� �� ���.
1) ���ڵ� ���� ��� 
 type ���ڵ��̸� is record (
    �����̸� ����Ÿ��,
    �����̸� ����Ÿ��,
    �����̸� ����Ÿ��,
    ... );
    
2) ���ڵ忡 ���� ����
 ���ڵ�.�ʵ� := ��;
*/
---------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
---------------------------------------------------------------------------------------------------
declare
    -- ���ڵ� ����
    type rec_dept is record (
        deptno number,
        dname varchar2(20),
        loc varchar2(20));
        
        -- ���ڵ���� ���� ���� ��, ���.
        v_dept_row rec_dept;
begin
    -- ���ڵ� ������ ����
    v_dept_row.deptno := 99;
    v_dept_row.dname := 'ITWILL';
    v_dept_row.loc := 'SEOUL';
    
    -- ���ڵ� ���� �� �о�� ���� ���ڵ庯��.�ʵ�
    DBMS_OUTPUT.PUT_LINE('��ȣ = ' || v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('�̸� = ' || v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('��ġ = ' || v_dept_row.loc);
end;
/
---------------------------------------------------------------------------------------------------
select * from dept2;

declare
    type rec_dept is record (
        deptno  dept2.deptno%type,
        dname   dept2.dname%type,
        loc     dept2.loc%type
    );
    
    v_row rec_dept;
begin
    v_row.deptno := 11;
    v_row.dname := '�����ͺ��̽�';
    v_row.loc := 'Seoul';
    
-- �Ϲ����� INSERT.
--    insert into dept2
--    VALUES (v_row.deptno,
--                v_row.deptno,
--                v_row.loc);

-- ���̺� ���ڵ� Ÿ�� ����� INSERT.  
    insert into dept2 
    VALUES v_row; -- ���� ������� ���� ���ڵ� ��ü�� �־��ָ� �ξ� ����.

-- �Ϲ����� UPDATE.
--    update dept2 
--    set deptno = 20, 
--         dname = '�����ͺ��̽�', 
--         loc = '������' 
--    where deptno = 11; 

-- ���ڵ� Ÿ�� ���� �����  UPDATE.
    v_row.deptno := 99;
    v_row.dname := '�����ͺ��̽�';
    v_row.loc := '������';
    
    update dept2
    set row = v_row
    where deptno =11;
    
    DBMS_OUTPUT.PUT_LINE('��ȣ = ' || v_row.deptno);
    DBMS_OUTPUT.PUT_LINE('�̸� = ' || v_row.dname);
    DBMS_OUTPUT.PUT_LINE('��ġ = ' || v_row.loc);
end;
/
---------------------------------------------------------------------------------------------------
declare
    -- row Ÿ�� ���� ���� ����.
    v_row1 dept%rowtype;
    -- ���̺� ����(�÷���, Ÿ��)�� �Ȱ��� ���ڵ� Ÿ��.
begin 
    v_row1.deptno := 22;
    v_row1.dname := 'ABC';
    v_row1.loc := 'KOREA';
    
    insert into dept2
    VALUES v_row1;

end;
/
---------------------------------------------------------------------------------------------------
select * from emp;

-- ���ڵ� �̿��� SELECT
declare
    -- 1) ���̺��� '��� �÷��� �˻�'�ϴ� ���, 
    -- ���ڵ带 ���� �����ϴ� �ͺ��� %rowtype ������ ����ϴ� ���� ���ϴ�. 
    v_emp_row1 emp%rowtype;
    
    -- 2) ���̺��� 'Ư�� �÷����� �˻�'�ϰų� '�ΰ� �̻��� ���̺��� ����'�ϴ� ���,
    -- ����ڰ� ���ڵ带 ���� �����ϴ� ���� ���ϴ�.
    type rec_emp is record (
        empno emp.empno%type,
        ename emp.ename%type,
        job emp.job%type);
        
        v_emp_row2 rec_emp;
begin
    -- 1) ���̺� ��ü �÷� �˻�
    select * into v_emp_row1 
    from emp 
    where empno = 7788;
    dbms_output.put_line(v_emp_row1.empno|| ', ' || v_emp_row1.ename);
    
    -- 2) ���̺� �Ϻ� �÷� �˻�
    select empno, ename, job into v_emp_row2
    from emp
    where empno = 7839;
    dbms_output.put_line(v_emp_row2.empno|| ', ' || v_emp_row2.ename || ', ' || v_emp_row2.job);

end;
/

-- emp ���̺�� dept ���̺��� ���, �̸�, �޿�, �μ���, �μ���ġ�� �����ϴ� ���ڵ带 �����
-- '����'�� �̿��� scott�� ������ ����ض�.
declare
    type emp_dept is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type,
        dname dept.dname%type,
        loc dept.loc%type);
        
        v_emp_dept emp_dept;
begin
    select e.empno, e.ename, e.sal, d.dname, d.loc into v_emp_dept
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = 7788;
    dbms_output.put_line(v_emp_dept.empno|| ', ' || v_emp_dept.ename || ', ' || v_emp_dept.sal 
                                    || ', ' || v_emp_dept.dname || ', '|| v_emp_dept.loc);

end;
/
---------------------------------------------------------------------------------------------------
-- emp ���̺�� salgrade ���̺��� ���, �̸�, �޿�, �޿������ �����ϴ� ���ڵ带 �����
-- '����'�� �̿��� scott�� ������ ����ض�.
declare
    type emp_sal is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type,
        grade salgrade.grade%type);
        
        v_emp_sal emp_sal;
begin
    select e.empno, e.ename, e.sal, s.grade into v_emp_sal
    from emp e join salgrade s
    on e.sal between s.losal and s.hisal 
    where e.empno = 7788 ;
    dbms_output.put_line(v_emp_sal.empno|| ', ' || v_emp_sal.ename || ', ' || v_emp_sal.sal 
                                    || ', ' || v_emp_sal.grade);

end;
/
---------------------------------------------------------------------------------------------------
