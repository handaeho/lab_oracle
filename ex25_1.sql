/*
-- 조건문

if 조건식 then
    true인 경우 실행할 문장;
else
     false인 경우 실행할 문장;
end if;

*/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

declare
    v_num number := 123;
begin 
    if mod(v_num ,2) = 1 then
        dbms_output.put_line('홀수');
    else
        DBMS_OUTPUT.put_line('짝수'); 
    end if;
    
    DBMS_OUTPUT.put_line('끝');
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

ACCEPT p_num PROMPT '숫자를 입력하세요.';

declare
    v_num number := &p_num;
begin 
    if mod(v_num ,2) = 1 then
        dbms_output.put_line('홀수');
    else
        DBMS_OUTPUT.put_line('짝수'); 
    end if;
    
    DBMS_OUTPUT.put_line('끝');
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

ACCEPT p_num PROMPT '숫자를 입력하세요.';

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
    
    DBMS_OUTPUT.put_line('끝');
end;
/
--------------------------------------------------------------------------------------------------------
-- 1) 입력 받은 숫자가 짝수? 홀수? 짝수이면 even_num / 홀수이면 odd_num
--      또한 짝수라면 4의 배수? ' Y' / 'n'출력.
set SERVEROUTPUT on;

ACCEPT p_num PROMPT '숫자를 입력하세요.';

declare
    v_num number := &p_num;
begin 
    if mod(v_num,2) = 0 then
        dbms_output.put_line('짝수(even_num)입니다.');
            if mod(v_num,4) = 0 then
             dbms_output.put_line('4의 배수 Y');
            else
              dbms_output.put_line('4의 배수 N');
            end if;
    else 
        DBMS_OUTPUT.put_line('홀수(odd_num)입니다.'); 
    end if;
    
    DBMS_OUTPUT.put_line('끝');
end;
/
--------------------------------------------------------------------------------------------------------
select power(5,2) from dual; -- power(x,y) = x^y
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

ACCEPT x_num PROMPT '밑변 길이를 입력하세요.';
ACCEPT y_num PROMPT '높이를 입력하세요.';
ACCEPT z_num PROMPT '빗변 길이를 입력하세요.';

declare
    a_num number := &x_num;
    b_num number := &y_num;
    c_num number := &z_num;
begin 
    if power(a_num,2)+power(b_num,2) = power(c_num,2) then
        dbms_output.put_line('직각삼각형입니다.');
    else 
        DBMS_OUTPUT.put_line('직각삼각형이 아닙니다.'); 
    end if;
    
    DBMS_OUTPUT.put_line('끝');
end;
/
--------------------------------------------------------------------------------------------------------
