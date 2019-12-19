/*
���� / ���� ó��
= declare ~ begin ~ end; �� ���°� �ƴ�, declare ~ begin ~ exception ~ end; ���·� ����� ��.

declare -> ����� : ���� / Ÿ�� / Ŀ�� ���� ��
begin -> ����� : ������ �ڵ� �ۼ�
exception ->����ó���� : begin���� ���� �� ���� �߻� ��, ó���ϴ� �κ�.     
    when �����̸�1 then
        �ش� ���� �߻���, ó���� ����;
    when �����̸�2 then
        �ش� ���� �߻���, ó���� ����;
    when �����̸�3 then
        �ش� ���� �߻���, ó���� ����;
    ...
    when others then
        ������ ������ ���ܰ� �ƴϰų�, ���ܸ��� �𸦶� ó���� �����;
        
��, �̶� '���� �̸�'�� '����Ŭ���� ����� ���� �̸�'�̾���Ѵ�. ex) value_error, invaild_number ���...
���� �𸥴ٸ�, when others then�� ����Ѵ�.
end;
/
 <������ ����>
(1) ������ ���� : SQL ������ ��߳� ���� ��ü�� �Ұ����� ����. exception ó�� �Ұ�.
(2) ���� �� ���� : ������ �°� �ۼ��� �Ǿ� ������ ����������, ���� �� ��� ������ ���� �߻��ϴ� ����.
                        exception ó�� ���.
*/
set SERVEROUTPUT on;

declare
    v_result number;
begin
--    DBMS_OUTPUT.PUT_LINE('���� ��');
--    v_result := '123';
--    DBMS_OUTPUT.put_line(v_result); 
-- ����Ŭ������ ���ڿ��� ���ڷ� ��ȯ�� �� ��, ���ڿ��ٸ� ������ ��ȯ���� ����.
    
--    DBMS_OUTPUT.PUT_LINE('���� ��');
--    v_result := 'abc';
--    DBMS_OUTPUT.put_line(v_result); 
-- ���� ���� ������ abc�� ���ڷ� �ٲ㺸������ �ƴϱ� ������ ����.

    DBMS_OUTPUT.PUT_LINE('���� ��');
        v_result := 123/10;
    DBMS_OUTPUT.put_line(v_result); 
-- ���� ����.

--     DBMS_OUTPUT.PUT_LINE('���� ��');
--        v_result := 123/0;
--    DBMS_OUTPUT.put_line(v_result); 
-- 0���� ������ �Ұ�. ���� ���� �߻�.

--    DBMS_OUTPUT.PUT_LINE('���� ��');
--    select deptno into v_result from emp where empno ='7788';
--    DBMS_OUTPUT.put_line(v_result); 
-- ���� ����.

--     DBMS_OUTPUT.PUT_LINE('���� ��');
--     select ename into v_result from emp where empno =7788;
--     DBMS_OUTPUT.put_line(v_result); 
-- ��� �̸��� ���ڿ��̱� ������ number Ÿ���� v_result���� ���� �Ұ�.

--    DBMS_OUTPUT.PUT_LINE('���� ��');
--    select * into v_result from emp;
--    DBMS_OUTPUT.put_line(v_result); 
-- number Ÿ���� v_result���� Ÿ���� ���� �ʾ� ��� ���ڵ带 ������ �� ����.

end;
/
--------------------------------------------------------------------------------------------------------------
-- ���� ó�� ����
declare
    v_result number;
begin 
    DBMS_OUTPUT.PUT_LINE('���� �߻� ��');
    v_result := 'abc';
    DBMS_OUTPUT.PUT_LINE('v_result');
exception
    when value_error then
        DBMS_OUTPUT.PUT_LINE('���ڰ� �ƴմϴ�.');
end;
/
--------------------------------------------------------------------------------------------------------------
declare
    v_result number;
begin 
    DBMS_OUTPUT.PUT_LINE('���� �߻� ��');
    v_result := 123/0;
    DBMS_OUTPUT.PUT_LINE('v_result');
exception
    when zero_divide then
        DBMS_OUTPUT.PUT_LINE('0���� ������ �ȵſ�.');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode);
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
-- others ��ϰ� zero_divide ����� ������ �ٲٸ� ���� �߻�. others ����� �׻� �� �������� �ʿ�.
end;
/
--------------------------------------------------------------------------------------------------------------
declare
    v_result number;
    v_row emp%rowtype;
begin
    select * into v_row from emp; -- where empno ='7788';
-- ������ ������ ����.
-- ���� where���� ��� ���ν����� ���������� �Ϸ������, exception�� others ��Ͽ� �ɷ� ���� �޽��� ��ȯ.
-- �� ��쿡�� when too_many_rows ����.
    DBMS_OUTPUT.PUT_LINE(v_row.ename);
exception
    when value_error then
        DBMS_OUTPUT.PUT_LINE('ERROR');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;
/