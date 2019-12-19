/*
1) �͸� ���(Anonymous block) = �̸��� �������� ���� PL/SQL ���
�̸��� ���� ������ ����Ŭ ������ ���� �Ұ�. ����(*.sql)�δ� ���� ����.
���� �� ������ ���� ������ ��.

2) ���� ���� ���α׷�(Stored Sub Program) = �̸��� �ִ� PL/SQL ���.
 -> ���ν���, �Լ�, ��Ű��, Ʈ����
 -> ����Ŭ ������ ����Ǵ� ��ü. ������ ����.
 -> ����Ŭ ������ ����� �� ������ ��. ����ӵ��� ����.
 
3) ���ν��� 
create [or replace] procedure ���ν����̸� [(
    �Ķ����1 [mode] Ÿ��,
    �Ķ����2 [mode] Ÿ��,
    ... )]
is
    ����� : ����, Ŀ�� ����. �����Ұ�.
begin
    ����� : ������ �ڵ� �ۼ�.
[exception]
end;
/

** ���ν��� �Ķ������ ��� **
1) in -> ���ν��� ȣ���, ������ ���� �����ϴ� �Ű�����
2) out -> ���ν����� ȣ���� ������ ���� ��ȯ�� �� ����ϴ� �Ű�����
3) in out -> ���� ���� �ޱ⵵, ��ȯ�ϱ⵵ �ϴ� �Ű�����

in�� default�ν� ���� ����������, out�� in out�� ���� �Ұ���.
*/
--------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
--------------------------------------------------------------------------------------------------------------
-- ���ν��� ����
create or replace procedure my_proc1
is
    v_empno emp.empno%type := 7788;
    v_ename emp.ename%type;
begin
    select ename into v_ename from emp where empno = v_empno;
    DBMS_OUTPUT.PUT_LINE(v_ename);
end;
/
--------------------------------------------------------------------------------------------------------------
-- ���ν��� ����. ����Ŭ�� ����Ǿ��� ������ ���� my_proc1�̶�� ���ν����� ������ �ҷ��� ��� ����.
begin
    my_proc1(); -- �Ķ���͸� �����ʴ� ���ν��� ȣ��ÿ��� () ���� ����.
end;
/
--------------------------------------------------------------------------------------------------------------
-- ���ν��� Ȯ��
select * from user_source where name = upper('my_proc1');
-- ���ν����� my_proc1�� �빮�ڷ� ����Ǳ� ������ upper�� �ٿ�����.
--------------------------------------------------------------------------------------------------------------
-- ���ν��� ����
drop procedure my_proc1;
--------------------------------------------------------------------------------------------------------------
-- �Ķ���͸� ���� ���ν��� ����
create or replace procedure my_proc2 (
    p_empno emp.empno%type)
is
    v_ename emp.ename%type;
begin
    select ename into v_ename from emp where empno = p_empno;
    DBMS_OUTPUT.put_line('NAME : ' || v_ename);
end;
/
--------------------------------------------------------------------------------------------------------------
-- ���ν��� ����
begin
    my_proc2(7788); -- �˻��� ���ϴ� ����� �־� ����. 
    -- ����� ������ ���ν��� ������ ������ sql���� ���� ����� �´� ����� �̸��� �˻��Ͽ� �����.
end;
/
--------------------------------------------------------------------------------------------------------------
declare
    cursor my_cursor is 
        select empno from emp;
begin
    for r in my_cursor loop
        my_proc2(r.empno);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace procedure my_proc3(
    in_empno emp.empno%type, -- in ��� �Ķ����
    out_ename out emp.ename%type, -- out ��� �Ķ����
    out_deptno out emp.deptno%type
)
is  -- ������� �ڵ尡 ������ is�� �����ϸ� �ȵ�!
begin
    select ename, deptno into out_ename, out_deptno
    from emp
    where empno = in_empno;
end;
/

declare
    v_ename emp.ename%type;
    v_deptno emp.deptno%type;
begin
    my_proc3(7788, v_ename, v_deptno); -- in���� ���� �ְ�, out������ ���� �޾ƿ´�.
    dbms_output.put_line(v_ename || ', ' || v_deptno);
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace procedure my_proc4(
   v_number in out number)
is  
begin
    v_number := 2 * v_number;
end;
/

declare
    v_test number := 10;
begin
    dbms_output.put_line('���ν��� ȣ�� �� = ' || v_test);
    my_proc4(v_test); -- v_number�� 10�� in / 20�̶�� ����� �ٽ� out.
    dbms_output.put_line('���ν��� ȣ�� �� = ' || v_test);
end;
/

create or replace procedure my_proc5(
   param1 number, -- �⺻�� ���� �Ķ����
   param2 number := 123) -- �⺻�� ������ �Ķ����
is  
begin
    dbms_output.put_line(param1 || ' , ' || param2);
end;
/

begin
    my_proc5(1, 2);
    my_proc5(100); -- �⺻���� ������ �Ķ���ʹ� ���� ���� ���� ���������� �� �⺻���� ����.
end;
/
--------------------------------------------------------------------------------------------------------------
-- EX 1. ���޹��� ������� �������� Ŀ�̼��� �˻��ϴ� ���ν���.
create or replace procedure get_toal_sal (
    p_empno in emp.empno%type,
    p_total out number,
    p_tax in number := 0.05)
is
    v_sal emp.sal%type;
    v_comm emp.comm%type;
begin
    select sal, nvl(comm,0) into v_sal, v_comm
    from emp
    where empno = p_empno;
    
    p_total := (v_sal + v_comm) * (1 - p_tax);
    dbms_output.put_line(p_empno || ' / ' || p_total);
end;
/

declare
    v_total number;
begin
    get_toal_sal(7839, v_total);
end;
/
