/*
-- ���ǹ�

if ���ǽ� then
    true�� ��� ������ ����;
else
     false�� ��� ������ ����;
end if;

*/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

declare
    v_num number := 123;
begin 
    if mod(v_num ,2) = 1 then
        dbms_output.put_line('Ȧ��');
    else
        DBMS_OUTPUT.put_line('¦��'); 
    end if;
    
    DBMS_OUTPUT.put_line('��');
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

ACCEPT p_num PROMPT '���ڸ� �Է��ϼ���.';

declare
    v_num number := &p_num;
begin 
    if mod(v_num ,2) = 1 then
        dbms_output.put_line('Ȧ��');
    else
        DBMS_OUTPUT.put_line('¦��'); 
    end if;
    
    DBMS_OUTPUT.put_line('��');
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

ACCEPT p_num PROMPT '���ڸ� �Է��ϼ���.';

declare
    v_score number := &p_score;
begin 
    if v_score >= 90 then
        dbms_output.put_line('A');
    elsif v_score >= 80 then
        DBMS_OUTPUT.put_line('B'); 
    elsif v_score >= 70 then
        DBMS_OUTPUT.put_line('C');
    else
        DBMS_OUTPUT.put_line('F');
    end if;
    
    DBMS_OUTPUT.put_line('��');
end;
/
--------------------------------------------------------------------------------------------------------
-- 1) �Է� ���� ���ڰ� ¦��? Ȧ��? ¦���̸� even_num / Ȧ���̸� odd_num
--      ���� ¦����� 4�� ���? ' Y' / 'n'���.
set SERVEROUTPUT on;

ACCEPT p_num PROMPT '���ڸ� �Է��ϼ���.';

declare
    v_num number := &p_num;
begin 
    if mod(v_num,2) = 0 then
        dbms_output.put_line('¦��(even_num)�Դϴ�.');
            if mod(v_num,4) = 0 then
             dbms_output.put_line('4�� ��� Y');
            else
              dbms_output.put_line('4�� ��� N');
            end if;
    else 
        DBMS_OUTPUT.put_line('Ȧ��(odd_num)�Դϴ�.'); 
    end if;
    
    DBMS_OUTPUT.put_line('��');
end;
/
--------------------------------------------------------------------------------------------------------
select power(5,2) from dual; -- power(x,y) = x^y
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

ACCEPT x_num PROMPT '�غ� ���̸� �Է��ϼ���.';
ACCEPT y_num PROMPT '���̸� �Է��ϼ���.';
ACCEPT z_num PROMPT '���� ���̸� �Է��ϼ���.';

declare
    a_num number := &x_num;
    b_num number := &y_num;
    c_num number := &z_num;
begin 
    if power(a_num,2)+power(b_num,2) = power(c_num,2) then
        dbms_output.put_line('�����ﰢ���Դϴ�.');
    else 
        DBMS_OUTPUT.put_line('�����ﰢ���� �ƴմϴ�.'); 
    end if;
    
    DBMS_OUTPUT.put_line('��');
end;
/
--------------------------------------------------------------------------------------------------------
