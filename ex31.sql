/*
컬렉션(collection): 같은 타입의 데이터 여러개를 저장할 때 사용
1) 연관 배열(associative array, index by table)
2) 중첩 테이블(nested table)
3) VARRAY(variable-size array)

연관 배열: key/index와 value의 쌍으로 구성되는 컬렉션
연관 배열에서 key/index는 
binary_integer(정수), pls_integer(양의 정수), varchar2(문자열) 타입이 가능.

연관 배열을 선언(정의)하는 방법:
type 배열이름 is table of 데이터타입 index by 인덱스타입;
*/

set serveroutput on;

declare
    -- 문자열을 원소로 갖고, 양의 정수를 인덱스로 사용하는 연관 배열을 정의
    type students is table of varchar2(20) 
        index by pls_integer;
    
    -- 정의한 연관 배열 타입의 변수 선언
    v_stu students;
begin
    -- 연관 배열에 데이터 저장: 배열이름(인덱스) := 값;
    v_stu(1) := '강다혜';
    v_stu(2) := '김수인';
    v_stu(3) := '김영광';
    
    -- 연관 배열에 저장된 원소(데이터)의 값을 읽을 때: 배열이름(인덱스)
    -- dbms_output.put_line(v_stu(1));
    for i in 1..3 loop
        dbms_output.put_line(i || ':' || v_stu(i));
    end loop;
end;
/

declare
    -- 인덱스 타입: varchar2(20), 원소의 타입: number인 연관 배열을 정의(선언)
    type arr_menu is table of number index by varchar2(20);
    
    -- 연관 배열 타입의 변수를 선언
    v_menu arr_menu;
begin
    -- 연관 배열에 데이터를 3개 저장
    v_menu('짜장면') := 1000;
    v_menu('보쌈') := 5000;
    v_menu('파스타') := 3000;
    
    -- 연관 배열에 저장된 데이터를 출력
    DBMS_OUTPUT.PUT_LINE(v_menu('짜장면'));
    DBMS_OUTPUT.PUT_LINE(v_menu('보쌈'));
    DBMS_OUTPUT.PUT_LINE(v_menu('파스타'));
end;
/

declare
    -- 인덱스: 양의 정수, 원소(데이터 타입): 숫자인 연관 배열(arr_numbers)을 선언(정의)
    type arr_numbers is table of number index by pls_integer;
    -- 연관 배열 타입의 변수(v_scores)를 선언
begin
    -- 연관 배열 v_scores에 5개의 정수(0 ~ 100)를 입력
    -- 5개 정수의 합계를 계산해서 출력
    -- 5개 정수의 평균을 계산해서 출력
end;
/


