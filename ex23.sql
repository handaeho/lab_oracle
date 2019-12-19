-- �̸��� �Է¹޾� ���, �̸�, �μ���ȣ�� ���.
set SERVEROUTPUT on;

accept p_ename prompt 'What is your name?';

declare

    v_ename emp.ename%type := upper('&p_ename'); 
    v_empno emp.empno%type; 
    v_deptno emp.deptno%type;

begin 
    
    select ename, empno, deptno into v_ename, v_empno, v_deptno
    from emp 
    where ename = v_ename;
    
    DBMS_OUTPUT.PUT_LINE(' empno is ' || v_empno || ' deptno is '  || v_deptno || ' name is ' || v_ename);
end;
/
------------------------------------------------------------------------------------------------------------
-- �̸� �Է¹޾� emp, dept ���̺��� ����� 'x�� y�� z �μ����� �ٹ��մϴ�.' �������� ���.
set SERVEROUTPUT on;

accept p_ename prompt 'What is your name?';

declare

    v_ename emp.ename%type := upper(trim('&p_ename'));
    v_deptno emp.deptno%type;
    v_dname dept.dname%type;
    v_loc dept.loc%type;

begin 
    
    select e.ename, e.deptno, d.dname, d.loc into v_ename, v_deptno, v_dname, v_loc
    from emp e , dept d 
    where e.ename = v_ename and e.deptno = d.deptno;
    
    DBMS_OUTPUT.PUT_LINE(v_ename || ' ��/�� ' || v_loc || ' �� ' || v_dname || ' ���� �ٹ��մϴ�. ');
end;
/
------------------------------------------------------------------------------------------------------------