/*
컬렉션(collection): 같은 타입의 데이터 여러개를 저장할 때 사용
1) 연관 배열(associative array, index by table)
2) 중첩 테이블(nested table)
3) VARRAY(variable-size array)

(1) 연관 배열(associative array, index by table)
= key/index와 value의 쌍으로 구성되는 컬렉션.
연관 배열에서 key/index는 binary_integer(정수), pls_integer(양의 정수), varchar2(문자열) 타입이 가능.
연관 배열을 선언(정의)하는 방법 -> type 배열이름 is table of 데이터타입 index by 인덱스타입;
저장 가능한 값의 개수 제한 없음.
생성자 사용 X.

(2) 중첩 테이블(nested table)
= 인덱스는 양의 정수만 가능 -> 인덱스 타입(index by)을 명시 X.
저장 가능한 값의 개수 제한 없음.
생성자 사용 필요.

(3) VARRAY(variable-size array)
= 인덱스는 양의 정수만 가능 -> 인덱스 타입(index by)을 명시 X.
선언 시, 저장 가능한 값의 개수 제한 존재. 저장 가능한 값의 개수 지정 필요.
생성자 사용 필요.
*/
--------------------------------------------------------------------------------------------------------------
set serveroutput on;
--------------------------------------------------------------------------------------------------------------
declare
-- 중첩 테이블 선언
    type NumberArray is table of number;
    
-- 중첩 테이블 변수 선언
    v_numbers NumberArray;
    
begin 
-- v_numbers(1) := 100; -> 안돼 이건. 중첩 테이블은 반드시 생성자 호출해 초기화 필요.
    v_numbers := NumberArray(100, 200, 300); --> 생성자. 타입의 이름과 같다. 
--생성자의 매개변수로 중첩 테이블 / VARRAY에 저장할 값들을 전달함.

-- 중첩 테이블에 값 추가
   -- v_numbers(4) := 400; --> 그냥 쓰면 에러 발생. 첨자가 개수를 넘어감.
   
    v_numbers.extend(2);  --> numbers의 개수를 extend 해주고 추가해야함.
    v_numbers(4) := 400;
    v_numbers(5) := 500;
    
    --저장 값 출력
    for i in 1..v_numbers.count loop
        dbms_output.put_line( i  || ' : ' || v_numbers(i));
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
declare
-- Varray type 선언
    type NumberArray is varray(5) of number;
    
    v_numbers NumberArray;
begin 
-- Varray 타입 변수 선언
    v_numbers := NumberArray(11, 22, 33); --> 반드시 생성자를 호출 후, Varray 사용 해야한다.
    
    dbms_output.put_line('count : ' || v_numbers.count);
    dbms_output.put_line('limit : '  || v_numbers.limit);
    
-- Varray에 원소 추가시, extend() 호출 후, 원소 추가 필요
    v_numbers.extend(2);
    v_numbers(4) := 44;
    v_numbers(5) := 55;
    
    for i in 1..v_numbers.count loop
        dbms_output.put_line(i || ' : ' || v_numbers(i));
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 문자열 5개를 저장할 수 있는 Varray를 선언. (StringArray / v_names)
-- v_names를 원소가 하나도 없는 varray로 초기화(생성자 호출)
-- 또한 저장 가능한 원소의 갯수를 5개 이상으로 확장
declare
    type StringArray is varray(5) of varchar(20);
    
    v_names StringArray;
begin
    v_names := StringArray();
    
    dbms_output.put_line('count : ' || v_names.count);
    dbms_output.put_line('limit : '  || v_names.limit);
    
    v_names.extend(5);
    v_names(1) := 'a';
    v_names(2) := 'b';
    v_names(3) := 'c';
    v_names(4) := 'd';
    v_names(5) := 'e';
    
    for i in 1..v_names.count loop
        dbms_output.put_line(i || ' : ' || v_names(i));
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------