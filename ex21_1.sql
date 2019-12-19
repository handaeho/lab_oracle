-- PL / SQL 
/*
emp 테이블에서 부서별 직원 정보 출력하기
 select * from emp where deptno = ?
 그런데 어떤 부서 번호가 있지? dept 테이블을 확인해 봐야 하는구나...
 select deptno from dept;
 이제 알아낸 부서 번호로 부서 수만큼 select를 해야한다.
 select * from emp where deptno =10;
 select * from emp where deptno =20;
 select * from emp where deptno =30;
 select * from emp where deptno =40;
따라서 작업을 절차적으로 진행해야 한다. --> PL (절차적 언어)
*/
/* 
PL / SQL의 기본구조 
 
declare ~  - 선택 사항
        변수 선언; 
begin~  
        실행문;
exception ~  - 선택 사항
        예외문; 
end;
/

*/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
DECLARE
    v_num number := 1004;
BEGIN
    DBMS_OUTPUT.PUT_LINE('v_num 값 = ' || v_num);
END;
/
------------------------------------------------------------------------------------------------------------
/*
PL / SQL 변수
변수 = 프로그램 또는 프로시저에서 사용되는 데이터를 저장하는 공간.
PL / SQL에서 변수 명은 대소문자 구분 X.
                  단, 변수 값은 대소문자 구분 O.

declare에서 다음 순서로 변수 선언 및 초기화 진행
1) 변수 선언 및 초기화 진행하는 경우.
    변수이름 데이터타입 := 값;
2) 변수 선언 후, 값 초기화 안하는 경우.
    변수이름 데이터타입;
    초기화되지 않은 변수는 begin 블록 내에서 반드시 초기화 필요.
    
*/
------------------------------------------------------------------------------------------------------------
declare
    v_age number(3) := 16;
    v_name varchar2(20);
begin
    DBMS_OUTPUT.PUT_LINE('나이:' || v_age);
    v_name := '오쌤';
    DBMS_OUTPUT.PUT_LINE('이름:' || v_name);
end;
/
------------------------------------------------------------------------------------------------------------
-- declare = declaration (선언) : 변수명과 데이터 타입을 선언.
-- assign, assignment (할당) : 선언된 변수에값을 저장 또는 변경 하는것.
-- initialize, initialization (초기화) : 변수에 최초로 값을 저장(할당) 하는것.
------------------------------------------------------------------------------------------------------------
accept p_age prompt 'How old are you?';

declare
    v_age number(3) := &p_age; -- & : 프롬프트에서 입력받은 값을 저장하는 변수를 참조.
begin 
    DBMS_OUTPUT.PUT_LINE('your age is = ' || v_age);
end;
/
------------------------------------------------------------------------------------------------------------
accept p_sizea PROMPT '가로길이?';
accept p_sizeb PROMPT '세로길이?';

declare
    v_size float := (&p_sizea * &p_sizeb);
begin
    DBMS_OUTPUT.PUT_LINE('Size is = ' || v_size);
END;
/
------------------------------------------------------------------------------------------------------------
