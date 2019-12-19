/*
�÷���(collection): ���� Ÿ���� ������ �������� ������ �� ���
1) ���� �迭(associative array, index by table)
2) ��ø ���̺�(nested table)
3) VARRAY(variable-size array)

���� �迭: key/index�� value�� ������ �����Ǵ� �÷���
���� �迭���� key/index�� 
binary_integer(����), pls_integer(���� ����), varchar2(���ڿ�) Ÿ���� ����.

���� �迭�� ����(����)�ϴ� ���:
type �迭�̸� is table of ������Ÿ�� index by �ε���Ÿ��;
*/

set serveroutput on;

declare
    -- ���ڿ��� ���ҷ� ����, ���� ������ �ε����� ����ϴ� ���� �迭�� ����
    type students is table of varchar2(20) 
        index by pls_integer;
    
    -- ������ ���� �迭 Ÿ���� ���� ����
    v_stu students;
begin
    -- ���� �迭�� ������ ����: �迭�̸�(�ε���) := ��;
    v_stu(1) := '������';
    v_stu(2) := '�����';
    v_stu(3) := '�迵��';
    
    -- ���� �迭�� ����� ����(������)�� ���� ���� ��: �迭�̸�(�ε���)
    -- dbms_output.put_line(v_stu(1));
    for i in 1..3 loop
        dbms_output.put_line(i || ':' || v_stu(i));
    end loop;
end;
/

declare
    -- �ε��� Ÿ��: varchar2(20), ������ Ÿ��: number�� ���� �迭�� ����(����)
    type arr_menu is table of number index by varchar2(20);
    
    -- ���� �迭 Ÿ���� ������ ����
    v_menu arr_menu;
begin
    -- ���� �迭�� �����͸� 3�� ����
    v_menu('¥���') := 1000;
    v_menu('����') := 5000;
    v_menu('�Ľ�Ÿ') := 3000;
    
    -- ���� �迭�� ����� �����͸� ���
    DBMS_OUTPUT.PUT_LINE(v_menu('¥���'));
    DBMS_OUTPUT.PUT_LINE(v_menu('����'));
    DBMS_OUTPUT.PUT_LINE(v_menu('�Ľ�Ÿ'));
end;
/

declare
    -- �ε���: ���� ����, ����(������ Ÿ��): ������ ���� �迭(arr_numbers)�� ����(����)
    type arr_numbers is table of number index by pls_integer;
    -- ���� �迭 Ÿ���� ����(v_scores)�� ����
begin
    -- ���� �迭 v_scores�� 5���� ����(0 ~ 100)�� �Է�
    -- 5�� ������ �հ踦 ����ؼ� ���
    -- 5�� ������ ����� ����ؼ� ���
end;
/


