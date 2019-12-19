/*
��Ű�� (Package)
= ��ɸ鿡�� �������� ���� ���ν���, �Լ�, Ÿ��(���ڵ�, �÷���) Ŀ�� ���� ��Ƶ� ���� ���α׷�.
��Ű�� ���� ��, '��Ű�� �� (spec)'�� '���� (body)'�� ���� ������ �Ѵ�.

1) ��Ű�� �� (spec)
create [or replace] package ��Ű���̸�
is
    Ÿ�� ����;
    ���ν��� ������Ÿ�� ����;
    �Լ� ������Ÿ�� ����;
    ...
end;
/

2) ��Ű�� ���� (body)
create [or replace] package body ��Ű���̸� -> �̶� ���� �̸��� ���ƾ���.
is
    ��Ű�� ������ ����� ���ν���, �Լ����� ����
end;
/

*/
----------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
----------------------------------------------------------------------------------------------------------------
-- ��Ű�� ��
create or replace package my_pkg
is
-- Ÿ�� ����
    type rec_emp is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type);
-- ���� ����
    num1 number := 0;
-- ���ν��� ������Ÿ�� ����
    procedure my_proc(p_empno number);
-- �Լ� ������Ÿ�� ����
    function my_add (p_x number, p_y number) return number;
end;
/

select my_add(1, 2) from dual; 
-- �̷��� �ϸ� ��Ű���� my_add�� �ƴϰ� �̹� ���ǵ� �Լ� my_add�� �����.

select my_pkg.my_add(1, 2) from dual;
-- �̷��� �ؾ� ��Ű�� ���� my_add �Լ��� �̿��Ѵ�.

-- ��Ű�� ����
create or replace package body my_pkg
is
-- ��Ű�� ���� ����� ���ν��� ����.
    procedure my_proc(p_empno number)
    is
        v_result my_pkg.rec_emp;
    begin
        select empno, ename, sal into v_result
        from emp
        where empno = p_empno;
        
        DBMS_OUTPUT.PUT_LINE(v_result.empno || ' / ' || v_result.ename || ' / ' || v_result.sal);
    end my_proc;
    
-- ��Ű�� ���� ����� �Լ� ����.
    function my_add(p_x number, p_y number)
    return number
    is
    begin
        return p_x + p_y;
    end my_add;
    
end;
/

declare
    v_result my_pkg.rec_emp;
begin
    DBMS_OUTPUT.PUT_LINE(my_pkg.num1);
    my_pkg.my_proc(7788);
end;
/
