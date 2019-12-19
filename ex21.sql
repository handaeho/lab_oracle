-- PL/SQL(Procudural Language extension to SQL)
-- SQL�� ���� ������ ��� Ȯ�� ���

-- PL/SQL�� �ʿ伺
-- ����(emp) ���̺��� �μ��� �������� ������ ���
select * from emp where deptno = ?;
-- � �μ� ��ȣ���� �ִ� ���� Ȯ���ϱ� ���ؼ� �μ�(dept) ���̺� Ȯ��
select deptno from dept;
-- �˾Ƴ� �μ� ��ȣ�� ������ select���� �μ� ������ŭ ����
select * from emp where deptno = 10;
select * from emp where deptno = 20;
select * from emp where deptno = 30;
select * from emp where deptno = 40;
-- �ϳ��� ������ �ϼ��ϱ� ���ؼ� �۾��� ���������� �����ؾ� �� �ʿ䰡 �ִ�.

/* PL/SQL ����� �⺻ ����
declare    -- �����. ���û���
    ���� ����;
begin      -- �����. �ʼ�����
    ���๮;
exception  -- ����ó����. ���û���
    ����ó����;
end;

o. declare, begin, exception���� �����ݷ�(;)�� ������� ����
o. end�� �� �����(���� ���� ����, ���๮, ���� ó����, ...) ������ 
�����ݷ�(;)�� �ݵ�� ���
o. PL/SQL ��� ���ο����� �ּ����� ����� �� ����.
o. sqlplus ���â������ PL/SQL ����� �������� ����ϱ� ���ؼ�
end; ���� �ٿ� ������(/)�� �� ��� ��.
*/

set serveroutput on;

declare
    /*
        ���� ���� �κ�
    */
    v_num number := 1000;
begin
    -- ȭ��(�ܼ�) ���
    dbms_output.put_line('v_num �� = ' || v_num);
end;
/


/* PL/SQL ����
����(variable): ���α׷�(���ν���)���� ���Ǵ� �����͸� �����ϴ� ����
PL/SQL���� ������ declare ��� �ȿ��� �Ʒ��� ���� �������� ����/�ʱ�ȭ�� ��
  1) ������ �����ϸ鼭 ���ÿ� ���� �Ҵ�(�ʱ�ȭ)�ϴ� ���
     �����̸� ������Ÿ�� := ��;
  2) ������ ���� �ϰ�, ���� �Ҵ�(�ʱ�ȭ)���� �ʴ� ���
     �����̸� ������Ÿ��;
     �ʱ�ȭ���� ���� ������ begin ��� �ȿ��� �ݵ�� �ʱ�ȭ�� �ؾ� ��.
PL/SQL�� ���� �̸��� ��/�ҹ��ڸ� �������� ����
������ ����� ���� ��/�ҹ��ڸ� ������
*/

declare  -- ���� �����
    -- ���� ����� ���ÿ� �ʱ�ȭ
    v_age number(3) := 16;
    
    -- ���� ����
    v_name varchar2(20);
begin  -- �����
    -- ȭ��(�ܼ�) ���
    dbms_output.put_line('����: ' || v_age);
    -- v_name�� �ʱ�ȭ���� ���� ����. v_name�� null.
    -- ����ο��� �ʱ�ȭ���� ���� ������ ����ο��� �ʱ�ȭ(���� ����)�� ��
    v_name := '����';
    dbms_output.put_line('�̸�: ' || v_name);
end;
/


-- declare, declaration(����): ������ �̸��� ������ ������ Ÿ���� ���ϴ� ��
-- assign, assignment(�Ҵ�): ����� ������ ���� ����/�����ϴ� ��
-- initialize, initialization(�ʱ�ȭ): ������ ���ʷ� ���� ����(�Ҵ�)�ϴ� ��


accept p_age prompt '���̰� ��� �Ǽ���~?';
declare
    v_age number := &p_age;
    -- &������: ������Ʈ â���� �Է¹��� ���� �����ϴ� ������ ����(reference)
begin
    dbms_output.put_line('����� ���̴� ' || v_age);
end;
/


-- ������Ʈ â���� ���簢���� ���ο� ���� ���̸� �Է¹޾Ƽ�
-- ���簢���� ���̸� ����ϰ�, �� ����� ȭ��(�ܼ�)�� ���
accept p_width prompt '����?';
accept p_height prompt '����?';
declare
    v_width number := &p_width;
    v_height number := &p_height;
    v_area number;
begin
    v_area := v_width * v_height;
    dbms_output.put_line('���� =  ' || v_width);
    dbms_output.put_line('���� =  ' || v_height);
    dbms_output.put_line('���� =  ' || v_area);
end;
/







