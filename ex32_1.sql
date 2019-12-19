/*
�÷���(collection): ���� Ÿ���� ������ �������� ������ �� ���
1) ���� �迭(associative array, index by table)
2) ��ø ���̺�(nested table)
3) VARRAY(variable-size array)

(1) ���� �迭(associative array, index by table)
= key/index�� value�� ������ �����Ǵ� �÷���.
���� �迭���� key/index�� binary_integer(����), pls_integer(���� ����), varchar2(���ڿ�) Ÿ���� ����.
���� �迭�� ����(����)�ϴ� ��� -> type �迭�̸� is table of ������Ÿ�� index by �ε���Ÿ��;
���� ������ ���� ���� ���� ����.
������ ��� X.

(2) ��ø ���̺�(nested table)
= �ε����� ���� ������ ���� -> �ε��� Ÿ��(index by)�� ��� X.
���� ������ ���� ���� ���� ����.
������ ��� �ʿ�.

(3) VARRAY(variable-size array)
= �ε����� ���� ������ ���� -> �ε��� Ÿ��(index by)�� ��� X.
���� ��, ���� ������ ���� ���� ���� ����. ���� ������ ���� ���� ���� �ʿ�.
������ ��� �ʿ�.
*/
--------------------------------------------------------------------------------------------------------------
set serveroutput on;
--------------------------------------------------------------------------------------------------------------
declare
-- ��ø ���̺� ����
    type NumberArray is table of number;
    
-- ��ø ���̺� ���� ����
    v_numbers NumberArray;
    
begin 
-- v_numbers(1) := 100; -> �ȵ� �̰�. ��ø ���̺��� �ݵ�� ������ ȣ���� �ʱ�ȭ �ʿ�.
    v_numbers := NumberArray(100, 200, 300); --> ������. Ÿ���� �̸��� ����. 
--�������� �Ű������� ��ø ���̺� / VARRAY�� ������ ������ ������.

-- ��ø ���̺� �� �߰�
   -- v_numbers(4) := 400; --> �׳� ���� ���� �߻�. ÷�ڰ� ������ �Ѿ.
   
    v_numbers.extend(2);  --> numbers�� ������ extend ���ְ� �߰��ؾ���.
    v_numbers(4) := 400;
    v_numbers(5) := 500;
    
    --���� �� ���
    for i in 1..v_numbers.count loop
        dbms_output.put_line( i  || ' : ' || v_numbers(i));
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
declare
-- Varray type ����
    type NumberArray is varray(5) of number;
    
    v_numbers NumberArray;
begin 
-- Varray Ÿ�� ���� ����
    v_numbers := NumberArray(11, 22, 33); --> �ݵ�� �����ڸ� ȣ�� ��, Varray ��� �ؾ��Ѵ�.
    
    dbms_output.put_line('count : ' || v_numbers.count);
    dbms_output.put_line('limit : '  || v_numbers.limit);
    
-- Varray�� ���� �߰���, extend() ȣ�� ��, ���� �߰� �ʿ�
    v_numbers.extend(2);
    v_numbers(4) := 44;
    v_numbers(5) := 55;
    
    for i in 1..v_numbers.count loop
        dbms_output.put_line(i || ' : ' || v_numbers(i));
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- ���ڿ� 5���� ������ �� �ִ� Varray�� ����. (StringArray / v_names)
-- v_names�� ���Ұ� �ϳ��� ���� varray�� �ʱ�ȭ(������ ȣ��)
-- ���� ���� ������ ������ ������ 5�� �̻����� Ȯ��
declare
    type StringArray is varray(5) of varchar(20);
    
    v_names StringArray;
begin
    v_names := StringArray();
    
    dbms_output.put_line('count : ' || v_names.count);
    dbms_output.put_line('limit : '  || v_names.limit);
    
    v_names.extend(5);
    v_names(1) := 'a';
    v_names(2) := 'b';
    v_names(3) := 'c';
    v_names(4) := 'd';
    v_names(5) := 'e';
    
    for i in 1..v_names.count loop
        dbms_output.put_line(i || ' : ' || v_names(i));
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------