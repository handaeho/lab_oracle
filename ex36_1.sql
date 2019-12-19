/*
Procedure vs Function
1) Procedure
= 특정 로직을 수행하기만 하고, 명시적으로 리턴하지 않는 서브 프로그램.
* 실행 -> 다른 PL/SQL(프로그램) 내부에서 실행됨. 단, SQL 문에서는 실행 불가.
* 파라미터 -> in, out, in out mode 사용 가능.
* 반환 -> 리턴문을 사용한 반환 X. out / inout 파라미터로 1개 이상의 값을 리턴은 가능.

2) Function
= 특정 기능을 수행한 뒤, 반드시 결과값을 리턴하는 서브 프로그램. 
* 실행 -> 다른 PL/SQL(프로그램) 내부 또는 SQL 문장 안에서 실행 가능.
* 파라미터 -> in mode만 사용. defualt이므로 생략 가능.
                out, in out mode를 갖는 함수는 SQL문에서 사용 불가. 
* 반환 -> 반드시 return문을 사용해 한 개의 값 반환 필요.   

## Function 선언 ##
create [or replace] function 함수이름 [(
    파라미터1 타입 [:= 기본 값],
    파라미터2 타입 [:= 기본 값],
    파라미터3 타입 [:= 기본 값]
    ... )]
return 리턴타입
is
begin
[exception]
end;
/

### Parameter vs Argument ###
1) Parameter (매개변수, 인자)
= 함수나 프로시저를 정의할 때, 전달 받는 값을 저장하는 변수.

2) Argument (인수, 전달인자)
= 함수나 프로시저를 호출할 때, 전달하는 값.
*/
--------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
--------------------------------------------------------------------------------------------------------------
create or replace function my_add(
    p_x number,
    p_y number)
return number
is
    v_result number; -- return값 저장 변수
begin
    v_result := p_x + p_y;
    return v_result; -- 함수를 호출한 곳으로 값을 return.
end;
/

-- 오라클 내장함수의 결과값 확인시, dual 더미 테이블 사용.
-- 작성한 함수 역시 SQL 문으로 결과 확인 가능.
select my_add(1,2) from dual;

-- 함수는 PL/SQL에서도 사용 가능.
declare
    v_result number;
begin
    v_result := my_add(100,200);
    dbms_output.put_line(v_result);
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace function my_sub(
    p_x number,
    p_y number)
return number
is
    v_result number;
begin
    v_result := p_x - p_y;
    return v_result;
end;
/

declare
    v_result number;
begin
    v_result := my_sub(200, 100);
    dbms_output.put_line(v_result);
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace function my_str(
    p_x varchar,
    p_y varchar)
return varchar
is
    v_result varchar(20);
begin
    v_result := concat(p_x, p_y);
    return v_result;
end;
/

declare
    v_result varchar(20);
begin
    v_result := my_str('hello', 'world');
    dbms_output.put_line(v_result);
end;
/
--------------------------------------------------------------------------------------------------------------
-- 사번과 세율을 파라미터로 전달받아 전체 급여를 구해라
create or replace function my_sal(
    p_empno number,
    p_tax number)
return number
is
    v_totsal number;
    p_sal emp.sal%type;
    p_comm emp.comm%type;
    
begin
    select sal, nvl(comm,0) into p_sal, p_comm from emp where empno = p_empno;
    v_totsal := (p_sal + p_comm) * (1 - p_tax);
    return v_totsal;
    
--    select (sal + nvl(comm,0)) * (1 - p_tax) into v_totsal from emp where empno = p_empno;
--    return v_totsal;
end;
/

declare
    v_totsal number;
begin
    v_totsal := my_sal(7788, 0.05);
    dbms_output.put_line(v_totsal);
end;
/
--------------------------------------------------------------------------------------------------------------
-- 팩토리얼 만들기
create or replace function my_fact(
    p_x number)
return number
is
    v_fact number := 1;    
begin
    for i in 1..p_x loop 
        v_fact := v_fact * i; 
    end loop;
   
    return v_fact;
end;
/

declare
    v_fact number;
begin
    v_fact := my_fact(10);
    dbms_output.put_line(v_fact);
end;
/
--------------OR---------------
create or replace function my_fact2(
    p_n number)
return number
is
    v_result number := -1; -- 계산 결과 저장
begin
    if p_n =0 then
        v_result := 1;
        
        elsif p_n > 0 then
            v_result := my_fact2(p_n-1) * p_n;
    end if;
    return v_result;
end;
/

declare
    v_fact2 number;
begin
    v_fact2 := my_fact2(5);
    dbms_output.put_line(v_fact2);
end;
/
--------------------------------------------------------------------------------------------------------------
