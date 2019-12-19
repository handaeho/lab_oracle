-- ����(variable): ���α׷�(���ν���)���� �ʿ��� ������(��)�� �����ϴ� ����
-- ���(constant): ���� �ѹ� ����(�Ҵ�)�Ǹ� ���� ������ �� ���� ����
-- ���ͷ�(literal): ���α׷�(���ν���)���� �������� ���Ǵ� ��

declare
    var1 number := 1;   -- ���� ���� & �ʱ�ȭ
    var2 varchar2(20);  -- ���� ����
    -- ��� ����:
    -- �����̸� constant ������Ÿ�� := ��;
    -- ����� ����� ���ÿ� �ʱ�ȭ�� �ؾ� ��!
    const1 constant number := 3.14;
    -- const2 constant number;
begin
    var1 := 2;  -- �������� �������� ���� ����(����, ���Ҵ�)�� �� �ִ�.
    var2 := '������';  -- ���� �� ������ ���� ����(�Ҵ�)
    -- const1 := 3.141592;  
    -- constant�� ����� ����(���)�� ���� ����(���Ҵ�)�� �� ����.
end;
/

set serveroutput on;
declare
    v_num number default 0;
begin
    dbms_output.put_line('v_num = ' || v_num);
end;
/


declare
    v_num1 number := 10;  -- null�� �� �� �ִ� ����(nullable)
    v_num2 number not null := 20;  -- null�� �� �� ���� ����
begin
    v_num1 := null;
--    v_num2 := null;  -- not null �������� null�� �Ҵ��� �� ����
end;
/


declare
    -- ����� �޿��� ������ �� �ִ� ������ ����
    v_sal number;
begin
    -- emp ���̺��� 7788�� ����� �޿��� �˻�
    select sal into v_sal from emp where empno = 7788;
    -- �˻��� 7788�� ����� �޿��� ȭ�鿡 ���
    dbms_output.put_line('�޿�: ' || v_sal);
end;
/

-- ����� �Է� �޾Ƽ�(accept ~ prompt ... )
-- �Է¹��� ����� ��� �̸��� �μ� ��ȣ�� �˻��ؼ� ȭ�鿡 ���
accept p_empno prompt '��� �Է�';
declare
    v_ename varchar2(10);  --  ��� �̸��� ������ ����
    v_deptno number(2);  -- �μ� ��ȣ�� ������ ����
--    v_empno number(4) := &p_empno;  -- ������Ʈ���� �Է¹��� ����� ������ ����
begin
--    select ename into v_ename from emp where empno = v_empno;
--    select deptno into v_deptno from emp where empno = v_empno;
    select ename, deptno
    into v_ename, v_deptno
    from emp
    where empno = &p_empno; -- v_empno;
    
    dbms_output.put_line('���: ' || &p_empno);
    dbms_output.put_line('�̸�: ' || v_ename);
    dbms_output.put_line('�μ� ��ȣ: ' || v_deptno);
end;
/

-- Ctrl + /: ���� Ŀ���� �ִ� ��ġ�� ������ �ּ� ó��/���� (toggle)

-- ����� �Է� �޾Ƽ� �ش� ������ �ѱ޿�(sal + comm)�� ȭ�鿡 ���
-- comm�� null�� ���� 0���� ���
accept p_empno prompt '��� �Է�...';
declare
    v_total_sal number(7, 2);  -- �ѱ޿�(sal+comm)�� ������ ���� ����.
begin
    select sal + nvl(comm, 0) into v_total_sal
    from emp
    where empno = &p_empno;
    
    dbms_output.put_line('��� ' || &p_empno || ' ����� �ѱ޿��� ' || v_total_sal);
end;
/

declare
    v_sal number(7, 2);  -- �޿�(sal)�� ������ ���� ����.
    v_comm number(7, 2);  -- ����(comm)�� ������ ���� ����.
    -- �ѱ޿�(sal+comm)�� ������ ���� ����
    v_total_sal number(7, 2); 
begin
    select sal, nvl(comm, 0) into v_sal, v_comm
    from emp
    where empno = &p_empno;
    
    v_total_sal := v_sal + v_comm;
    dbms_output.put_line('��� ' || &p_empno || 
                    ' ����� �ѱ޿��� ' || v_total_sal);
end;
/












