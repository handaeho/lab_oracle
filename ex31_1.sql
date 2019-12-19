/*
�÷��� : ���� Ÿ���� ������ �������� ����ÿ� ���.
1) ���� �迭 (associative array, index by table)
2) ��ø ���̺� (nested table)
3) V array (Variable-size array)

- 1) �����迭 : Ű or �ε����� value�� ������ �����Ǵ� �÷���.
    ���� �迭���� Ű or �ε����� binary_integer(����) / pls_integer(���� ����) / varchar2(���ڿ�) Ÿ���� ����.
    ����(����) ��� : type �迭�̸� is table of ������Ÿ�� index by �ε���Ÿ��;
*/

set SERVEROUTPUT on;

declare
    -- ���ڿ��� ���ҷ� ������, ���� ������ �ε����� ����ϴ� ���� �迭 ����.
    type students is table of varchar2(20) index by pls_integer;
    
    -- ������ ���� �迭 Ÿ�� ���� ����
    v_stu students;
begin 
    -- ���� �迭�� ������ ����. �迭�̸�(�ε���) := ��;
    v_stu(1) := '������';
    v_stu(2) := '�����';
    v_stu(3) := '�迵��';
    
    -- �����迭�� ����� ����(������)�� ���� �о� �� ��. �迭�̸�(�ε���)
    -- DBMS_OUTPUT.PUT_LINE(v_stu(1) || ' ' || v_stu(2) || ' ' || v_stu(3));
    for i in 1..3 loop
        DBMS_OUTPUT.PUT_LINE(v_stu(i));
    end loop; 
end;
/

declare
    type students1 is table of number index by varchar2(20);
    
    v_stu1 students1;
begin
    v_stu1('a') := 123;
    v_stu1('b') := 456;
    v_stu1('c') := 789;
    
    DBMS_OUTPUT.PUT_LINE(v_stu1('a') || ' ' || v_stu1('b') || ' ' || v_stu1('c'));
end;
/

