/*
PL / SQL�� ������ Ÿ��
1) ��Į�� Ÿ�� : number, date, varchar2, ...
2) ���۷��� Ÿ�� : Ư�� ���̺��� �ο� �Ǵ� �÷��� ����. 
3) ���Ŀ�� Ÿ��(���� ������ Ÿ��) : �÷���, ���ڵ� 

�÷� ���� Ÿ�� ���� ���� : �����̸�(�ĺ���) ���̺��̸�.�÷��̸�%type := ��; 
--> Ư�� ���̺��� �÷� Ÿ�԰� ������ ������ Ÿ���� ����ϰڴ�.

�ο� ���� Ÿ�� ���� ���� : �����̸� ���̺��̸�%rowtype := ��;
--> Ư�� ���̺��� �ο� Ÿ�԰� ������ ������ Ÿ���� ����ϰڴ�.
*/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

declare
    -- dept ���̺��� �� �÷��� ������ ���� ������ ���� ����
    v_deptno dept.deptno%type := 10;
    v_dname dept.dname%type;
    v_loc dept.loc%type;
    
begin
    select dname, loc into v_dname, v_loc 
    from dept 
    where deptno = v_deptno;
    
    DBMS_OUTPUT.put_line(v_deptno || ' : ' || v_dname || ' : ' || v_loc || ' : ');
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

declare
    -- emp ���̺� �ο��� ��� ������ ���� ������ ���� ����
    v_emp7788 emp%rowtype;
begin
    select * into v_emp7788 
    from emp
    where empno =7788;
    
    DBMS_OUTPUT.put_line(v_emp7788.ename);
    DBMS_OUTPUT.put_line(v_emp7788.sal);
    DBMS_OUTPUT.put_line(v_emp7788.hiredate);
end;
/
--------------------------------------------------------------------------------------------------------