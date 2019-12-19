/*
- ���� (variable) : ���α׷����� �ʿ� ������(��)�� �����ϴ� ����.
- ��� (constant) : ���� �� �� ����Ǹ� ���� �Ұ��� ����.
- ���ͷ� (literal) : ���α׷����� ���Ǵ� ������ ��.
*/
------------------------------------------------------------------------------------------------------------
-- EX
declare 
    var1 NUMBER := 1; --> var1 = ����
    var2 varchar2(20) := 'abc';  --> var2 = ����
    const1 CONSTANT number := 3.14; --> const1 = ���, ����� ���ÿ� �ʱ�ȭ �ʿ�.
begin
    var1 := 2;
    var2 := '������'; 
end;
/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT ON;

declare
    v_num number DEFAULT 0; -->������ ����� ���ÿ� �ʱ�ȭ ����.
begin
    DBMS_OUTPUT.PUT_LINE('v_num = ' || v_num);
end;
/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT ON;
declare
    v_num1 number := 10;
    v_num2 number not null := 20;
begin
    v_num1 := null; --> null ������.
   -- v_num2 := null; --> null �� ������.
end;
/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT ON;

declare 
    v_sal number; -- �޿� ���� ���� ����
begin
    select sal into v_sal from emp where empno = 7788; 
    --emp ���̺��� 7788 ����� �޿� �˻� �� v_sal�� ����.
    DBMS_OUTPUT.put_line('�޿��� ' || v_sal);
end;
/
------------------------------------------------------------------------------------------------------------
-- ����� �Է� �޾� �̸��� �μ���ȣ �˻��� ���.
accept p_empno prompt 'What is your number?';

declare
    v_empno number := &p_empno; 
    v_deptno number;
    v_name varchar2(20); 
begin 
    select ename into v_name from emp where empno = v_empno;
    select deptno into v_deptno from emp where empno = v_empno;
    DBMS_OUTPUT.PUT_LINE('deptno is '  || v_deptno || 'name is' || v_name);
end;
/
------------------------------------------------------------------------------------------------------------
-- ����� �Է� �޾� �ش� ���� �� �޿� ���
accept p_empno prompt 'What is your number?';

declare
    v_empno number := &p_empno; 
    v_deptno number;
    v_name varchar2(20);
    v_sal number;
    v_comm number;
    v_tosal number;
begin 
    select ename, deptno, sal, comm into v_name, v_deptno, v_sal, v_comm 
    from emp 
    where empno = v_empno;
    
    if(v_comm is null) 
    then v_comm := 0;
    end if;
    
    v_tosal := v_sal + v_comm;
    
    DBMS_OUTPUT.PUT_LINE(' deptno is '  || v_deptno || ' name is ' || v_name || ' total sal is ' || v_tosal);
end;
/
------------------------------------------------------------------------------------------------------------