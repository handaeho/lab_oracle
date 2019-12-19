/*
Case ~ when
(1)
case 비교대상 
    when 값1 then
    비교대상 = 값1 만족할 때까지 실행할 문장;
    
    when 값2 then
    비교대상 = 값2 만족할 때까지 실행할 문장;
    
    ...
    
    else  비교대상이 위의 모든 값과 일치하지 않을때 실행할 문장;
end case;

(2)
case
    when 조건식1 then
        조건식1이 true인 경우 실행할 문장;
    when 조건식2 then
        조건식2가 true인 경우 실행 할 문장;
    ...
    else  위의 모든 조건이 false일 경우 실행할 문장;
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
ACCEPT p_score PROMPT '숫자를 입력하세요.';

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
