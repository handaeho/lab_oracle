/*
컬렉션 : 같은 타입의 데이터 여러개를 저장시에 사용.
1) 연관 배열 (associative array, index by table)
2) 중첩 테이블 (nested table)
3) V array (Variable-size array)

- 1) 연관배열 : 키 or 인덱스와 value의 쌍으로 구성되는 컬렉션.
    연관 배열에서 키 or 인덱스는 binary_integer(정수) / pls_integer(양의 정수) / varchar2(문자열) 타입이 가능.
    선언(정의) 방법 : type 배열이름 is table of 데이터타입 index by 인덱스타입;
*/

set SERVEROUTPUT on;

declare
    -- 문자열을 원소로 가지며, 양의 정수를 인덱스로 사용하는 연관 배열 정의.
    type students is table of varchar2(20) index by pls_integer;
    
    -- 정의한 연관 배열 타입 변수 선언
    v_stu students;
begin 
    -- 연관 배열에 데이터 저장. 배열이름(인덱스) := 값;
    v_stu(1) := '강다혜';
    v_stu(2) := '김수인';
    v_stu(3) := '김영광';
    
    -- 연관배열에 저장된 원소(데이터)의 값을 읽어 올 때. 배열이름(인덱스)
    -- DBMS_OUTPUT.PUT_LINE(v_stu(1) || ' ' || v_stu(2) || ' ' || v_stu(3));
    for i in 1..3 loop
        DBMS_OUTPUT.PUT_LINE(v_stu(i));
    end loop; 
end;
/

declare
    type students1 is table of number index by varchar2(20);
    
    v_stu1 students1;
begin
    v_stu1('a') := 123;
    v_stu1('b') := 456;
    v_stu1('c') := 789;
    
    DBMS_OUTPUT.PUT_LINE(v_stu1('a') || ' ' || v_stu1('b') || ' ' || v_stu1('c'));
end;
/

