/*
1) 익명 블록(Anonymous block) = 이름을 지정하지 않은 PL/SQL 블록
이름이 없기 떄문에 오라클 서버에 저장 불가. 파일(*.sql)로는 저장 가능.
실행 될 때마다 새로 컴파일 됨.

2) 저장 서브 프로그램(Stored Sub Program) = 이름이 있는 PL/SQL 블록.
 -> 프로시저, 함수, 패키지, 트리거
 -> 오라클 서버에 저장되는 객체. 재사용이 가능.
 -> 오라클 서버에 저장될 때 컴파일 됨. 실행속도가 빠름.
 
3) 프로시저 
create [or replace] procedure 프로시저이름 [(
    파라미터1 [mode] 타입,
    파라미터2 [mode] 타입,
    ... )]
is
    선언부 : 변수, 커서 선언. 생략불가.
begin
    실행부 : 절차적 코드 작성.
[exception]
end;
/

** 프로시저 파라미터의 모드 **
1) in -> 프로시저 호출시, 전달한 값을 저장하는 매개변수
2) out -> 프로시저를 호출한 곳으로 값을 반환할 때 사용하는 매개변수
3) in out -> 값을 전달 받기도, 반환하기도 하는 매개변수

in은 default로써 생략 가능하지만, out과 in out는 생략 불가능.
*/
--------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
--------------------------------------------------------------------------------------------------------------
-- 프로시저 생성
create or replace procedure my_proc1
is
    v_empno emp.empno%type := 7788;
    v_ename emp.ename%type;
begin
    select ename into v_ename from emp where empno = v_empno;
    DBMS_OUTPUT.PUT_LINE(v_ename);
end;
/
--------------------------------------------------------------------------------------------------------------
-- 프로시저 실행. 오라클에 저장되었기 때문에 이제 my_proc1이라는 프로시저는 언제든 불러와 사용 가능.
begin
    my_proc1(); -- 파라미터를 갖지않는 프로시저 호출시에는 () 생략 가능.
end;
/
--------------------------------------------------------------------------------------------------------------
-- 프로시저 확인
select * from user_source where name = upper('my_proc1');
-- 프로시저인 my_proc1은 대문자로 저장되기 때문에 upper를 붙여주자.
--------------------------------------------------------------------------------------------------------------
-- 프로시저 삭제
drop procedure my_proc1;
--------------------------------------------------------------------------------------------------------------
-- 파라미터를 갖는 프로시저 생성
create or replace procedure my_proc2 (
    p_empno emp.empno%type)
is
    v_ename emp.ename%type;
begin
    select ename into v_ename from emp where empno = p_empno;
    DBMS_OUTPUT.put_line('NAME : ' || v_ename);
end;
/
--------------------------------------------------------------------------------------------------------------
-- 프로시저 실행
begin
    my_proc2(7788); -- 검색을 원하는 사번을 넣어 실행. 
    -- 사번을 넣으면 프로시저 생성시 작정한 sql문에 의해 사번에 맞는 사원의 이름을 검색하여 출력함.
end;
/
--------------------------------------------------------------------------------------------------------------
declare
    cursor my_cursor is 
        select empno from emp;
begin
    for r in my_cursor loop
        my_proc2(r.empno);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace procedure my_proc3(
    in_empno emp.empno%type, -- in 모드 파라미터
    out_ename out emp.ename%type, -- out 모드 파라미터
    out_deptno out emp.deptno%type
)
is  -- 선언부의 코드가 없더라도 is는 생략하면 안됨!
begin
    select ename, deptno into out_ename, out_deptno
    from emp
    where empno = in_empno;
end;
/

declare
    v_ename emp.ename%type;
    v_deptno emp.deptno%type;
begin
    my_proc3(7788, v_ename, v_deptno); -- in에는 값을 주고, out에서는 값을 받아온다.
    dbms_output.put_line(v_ename || ', ' || v_deptno);
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace procedure my_proc4(
   v_number in out number)
is  
begin
    v_number := 2 * v_number;
end;
/

declare
    v_test number := 10;
begin
    dbms_output.put_line('프로시저 호출 전 = ' || v_test);
    my_proc4(v_test); -- v_number에 10이 in / 20이라는 결과가 다시 out.
    dbms_output.put_line('프로시저 호출 후 = ' || v_test);
end;
/

create or replace procedure my_proc5(
   param1 number, -- 기본값 없는 파라미터
   param2 number := 123) -- 기본값 지정된 파라미터
is  
begin
    dbms_output.put_line(param1 || ' , ' || param2);
end;
/

begin
    my_proc5(1, 2);
    my_proc5(100); -- 기본값이 지정된 파라미터는 값을 따로 주지 않을때에만 그 기본값이 사용됨.
end;
/
--------------------------------------------------------------------------------------------------------------
-- EX 1. 전달받은 사번으로 샐러리와 커미션을 검색하는 프로시저.
create or replace procedure get_toal_sal (
    p_empno in emp.empno%type,
    p_total out number,
    p_tax in number := 0.05)
is
    v_sal emp.sal%type;
    v_comm emp.comm%type;
begin
    select sal, nvl(comm,0) into v_sal, v_comm
    from emp
    where empno = p_empno;
    
    p_total := (v_sal + v_comm) * (1 - p_tax);
    dbms_output.put_line(p_empno || ' / ' || p_total);
end;
/

declare
    v_total number;
begin
    get_toal_sal(7839, v_total);
end;
/
