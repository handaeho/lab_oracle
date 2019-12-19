/*
패키지 (Package)
= 기능면에서 연관성이 높은 프로시저, 함수, 타입(레코드, 컬렉션) 커서 등을 모아둔 서브 프로그램.
패키지 생성 시, '패키지 명세 (spec)'와 '본문 (body)'를 따로 만들어야 한다.

1) 패키지 명세 (spec)
create [or replace] package 패키지이름
is
    타입 선언;
    프로시저 프로토타입 선언;
    함수 프로토타입 선언;
    ...
end;
/

2) 패키지 본문 (body)
create [or replace] package body 패키지이름 -> 이때 명세의 이름과 같아야함.
is
    패키지 명세에서 선언된 프로시저, 함수등을 구현
end;
/

*/
----------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
----------------------------------------------------------------------------------------------------------------
-- 패키지 명세
create or replace package my_pkg
is
-- 타입 선언
    type rec_emp is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type);
-- 변수 선언
    num1 number := 0;
-- 프로시저 프로토타입 선언
    procedure my_proc(p_empno number);
-- 함수 프로토타입 선언
    function my_add (p_x number, p_y number) return number;
end;
/

select my_add(1, 2) from dual; 
-- 이렇게 하면 패키지의 my_add가 아니고 이미 정의된 함수 my_add로 연산됨.

select my_pkg.my_add(1, 2) from dual;
-- 이렇게 해야 패키지 안의 my_add 함수를 이용한다.

-- 패키지 본문
create or replace package body my_pkg
is
-- 패키지 명세에 선언된 프로시저 구현.
    procedure my_proc(p_empno number)
    is
        v_result my_pkg.rec_emp;
    begin
        select empno, ename, sal into v_result
        from emp
        where empno = p_empno;
        
        DBMS_OUTPUT.PUT_LINE(v_result.empno || ' / ' || v_result.ename || ' / ' || v_result.sal);
    end my_proc;
    
-- 패키지 명세에 선언된 함수 구현.
    function my_add(p_x number, p_y number)
    return number
    is
    begin
        return p_x + p_y;
    end my_add;
    
end;
/

declare
    v_result my_pkg.rec_emp;
begin
    DBMS_OUTPUT.PUT_LINE(my_pkg.num1);
    my_pkg.my_proc(7788);
end;
/
