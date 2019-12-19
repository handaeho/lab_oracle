/*
예외 / 오류 처리
= declare ~ begin ~ end; 의 형태가 아닌, declare ~ begin ~ exception ~ end; 형태로 만들면 됨.

declare -> 선언부 : 변수 / 타입 / 커서 선언 등
begin -> 실행부 : 절차적 코드 작성
exception ->예외처리부 : begin에서 실행 중 오류 발생 시, 처리하는 부분.     
    when 예외이름1 then
        해당 예외 발생시, 처리할 문장;
    when 예외이름2 then
        해당 예외 발생시, 처리할 문장;
    when 예외이름3 then
        해당 예외 발생시, 처리할 문장;
    ...
    when others then
        위에서 선언한 예외가 아니거나, 예외명을 모를때 처리할 문장들;
        
단, 이때 '예외 이름'은 '오라클에서 명명한 오류 이름'이어야한다. ex) value_error, invaild_number 등등...
만약 모른다면, when others then을 써야한다.
end;
/
 <에러의 종류>
(1) 컴파일 에러 : SQL 문법에 어긋나 실행 자체가 불가능한 오류. exception 처리 불가.
(2) 실행 중 에러 : 문법에 맞게 작성이 되어 실행은 가능하지만, 실행 중 어떠한 이유로 인해 발생하는 에러.
                        exception 처리 대상.
*/
set SERVEROUTPUT on;

declare
    v_result number;
begin
--    DBMS_OUTPUT.PUT_LINE('실행 전');
--    v_result := '123';
--    DBMS_OUTPUT.put_line(v_result); 
-- 오라클에서는 문자열을 숫자로 변환해 본 뒤, 숫자였다면 에러를 반환하지 않음.
    
--    DBMS_OUTPUT.PUT_LINE('실행 전');
--    v_result := 'abc';
--    DBMS_OUTPUT.put_line(v_result); 
-- 따라서 위의 문장은 abc를 숫자로 바꿔보았지만 아니기 때문에 에러.

    DBMS_OUTPUT.PUT_LINE('실행 전');
        v_result := 123/10;
    DBMS_OUTPUT.put_line(v_result); 
-- 정상 실행.

--     DBMS_OUTPUT.PUT_LINE('실행 전');
--        v_result := 123/0;
--    DBMS_OUTPUT.put_line(v_result); 
-- 0으로 나누기 불가. 따라서 오류 발생.

--    DBMS_OUTPUT.PUT_LINE('실행 전');
--    select deptno into v_result from emp where empno ='7788';
--    DBMS_OUTPUT.put_line(v_result); 
-- 정상 실행.

--     DBMS_OUTPUT.PUT_LINE('실행 전');
--     select ename into v_result from emp where empno =7788;
--     DBMS_OUTPUT.put_line(v_result); 
-- 사원 이름은 문자열이기 때문에 number 타입의 v_result에는 저장 불가.

--    DBMS_OUTPUT.PUT_LINE('실행 전');
--    select * into v_result from emp;
--    DBMS_OUTPUT.put_line(v_result); 
-- number 타입의 v_result에는 타입이 맞지 않아 모든 레코드를 저장할 수 없음.

end;
/
--------------------------------------------------------------------------------------------------------------
-- 예외 처리 구문
declare
    v_result number;
begin 
    DBMS_OUTPUT.PUT_LINE('예외 발생 전');
    v_result := 'abc';
    DBMS_OUTPUT.PUT_LINE('v_result');
exception
    when value_error then
        DBMS_OUTPUT.PUT_LINE('숫자가 아닙니다.');
end;
/
--------------------------------------------------------------------------------------------------------------
declare
    v_result number;
begin 
    DBMS_OUTPUT.PUT_LINE('예외 발생 전');
    v_result := 123/0;
    DBMS_OUTPUT.PUT_LINE('v_result');
exception
    when zero_divide then
        DBMS_OUTPUT.PUT_LINE('0으로 나누면 안돼요.');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode);
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
-- others 블록과 zero_divide 블록의 순서를 바꾸면 에러 발생. others 블록은 항상 맨 마지막에 필요.
end;
/
--------------------------------------------------------------------------------------------------------------
declare
    v_result number;
    v_row emp%rowtype;
begin
    select * into v_row from emp; -- where empno ='7788';
-- 실행중 에러의 예시.
-- 만약 where절이 없어도 프로시저는 성공적으로 완료되지만, exception의 others 블록에 걸려 에러 메시지 반환.
-- 이 경우에는 when too_many_rows 에러.
    DBMS_OUTPUT.PUT_LINE(v_row.ename);
exception
    when value_error then
        DBMS_OUTPUT.PUT_LINE('ERROR');
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;
/