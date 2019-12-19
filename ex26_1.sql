/*
Case ~ when
(1)
case �񱳴�� 
    when ��1 then
    �񱳴�� = ��1 ������ ������ ������ ����;
    
    when ��2 then
    �񱳴�� = ��2 ������ ������ ������ ����;
    
    ...
    
    else  �񱳴���� ���� ��� ���� ��ġ���� ������ ������ ����;
end case;

(2)
case
    when ���ǽ�1 then
        ���ǽ�1�� true�� ��� ������ ����;
    when ���ǽ�2 then
        ���ǽ�2�� true�� ��� ���� �� ����;
    ...
    else  ���� ��� ������ false�� ��� ������ ����;
end case;

*/ 
set serveroutput on;

declare
    v_score number := 88;
begin
    case trunc(v_score,-1)
        when 100 then
            dbms_output.put_line('A');
        when 90 then
             dbms_output.put_line('B');
        when 80 then
             dbms_output.put_line('C');
        when 70 then
             dbms_output.put_line('F');
    
    end case;
end;
/
--------------------------------------------------------------------------------------------------------
set serveroutput on;
ACCEPT p_score PROMPT '���ڸ� �Է��ϼ���.';

DECLARE
    v_score number := &p_score; 
begin
    case
        when v_score = 100 then
            dbms_output.put_line('A');
         when v_score >= 90 then
            dbms_output.put_line('B');
         when v_score >= 80 then
            dbms_output.put_line('C');
         when v_score >= 70 then
            dbms_output.put_line('D');
    else  
        dbms_output.put_line('F');
end case;
end;
/
--------------------------------------------------------------------------------------------------------
