/* 조건문(Conditional Statement)
(1)
if 조건식 then
    조건식이 참일 때 실행할 문장;
end if;

(2)
if 조건식 then
    조건식이 참일 때 실행할 문장;
else
    조건식이 거짓일 때 실행할 문장;
end if;

(3)
if 조건식1 then
    조건식1이 참일 때 실행할 문장;
elsif 조건식2 then
    조건식2이 참일 때 실행할 문장;
elsif ...
    ...
else
    위의 모든 조건이 거짓일 때 실행할 문장;
end if;
*/


set serveroutput on;

declare
    v_num number := 122;
begin
    if mod(v_num, 2) = 1 then
        dbms_output.put_line('홀수');
    end if;
    
    dbms_output.put_line('End PL/SQL');
end;
/

accept p_num prompt '숫자를 입력하세요...';
declare
    v_test number := &p_num;
begin
    if mod(v_test, 2) = 1 then
        dbms_output.put_line('odd number');
    else
        dbms_output.put_line('even number');
    end if;
    
    dbms_output.put_line('End PL/SQL');
end;
/

-- 시험 점수가 90점 이상이면 'A'
-- 시험 점수가 80점 이상이면 'B'
-- 시험 점수가 70점 이상이면 'C'
-- 시험 점수가 70점 미만이면 'F'
declare
    v_score number := 68;
begin
    if v_score >= 90 then
        dbms_output.put_line('A');
    elsif v_score >= 80 then
        dbms_output.put_line('B');
    elsif v_score >= 70 then
        dbms_output.put_line('C');
    else
        dbms_output.put_line('F');
    end if;
end;
/

-- 입력받은 숫자가 
-- 1. 짝수이면, 'even number'라고 출력
--    (1) 4의 배수이면, '4의 배수'라고 출력
--    (2) 그렇지 않으면, '4의 배수가 아닙니다.'라고 출력 
-- 2. 홀수이면, 'odd number'라고 출력
accept p_num prompt '정수를 입력하세요...';
declare
    v_test number := &p_num;
begin

end;
/











