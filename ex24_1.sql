/*
PL / SQL의 데이터 타입
1) 스칼라 타입 : number, date, varchar2, ...
2) 레퍼런스 타입 : 특정 테이블의 로우 또는 컬럼을 참조. 
3) 컴파운드 타입(복합 데이터 타입) : 컬렉션, 레코드 

컬럼 참조 타입 변수 선언 : 변수이름(식별자) 테이블이름.컬럼이름%type := 값; 
--> 특정 테이블의 컬럼 타입과 동일한 데이터 타입을 사용하겠다.

로우 참조 타입 변수 선언 : 변수이름 테이블이름%rowtype := 값;
--> 특정 테이블의 로우 타입과 동일한 데이터 타입을 사용하겠다.
*/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

declare
    -- dept 테이블의 각 컬럼의 값들을 저장 가능한 변수 선언
    v_deptno dept.deptno%type := 10;
    v_dname dept.dname%type;
    v_loc dept.loc%type;
    
begin
    select dname, loc into v_dname, v_loc 
    from dept 
    where deptno = v_deptno;
    
    DBMS_OUTPUT.put_line(v_deptno || ' : ' || v_dname || ' : ' || v_loc || ' : ');
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;

declare
    -- emp 테이블 로우의 모든 정보를 저장 가능한 변수 선언
    v_emp7788 emp%rowtype;
begin
    select * into v_emp7788 
    from emp
    where empno =7788;
    
    DBMS_OUTPUT.put_line(v_emp7788.ename);
    DBMS_OUTPUT.put_line(v_emp7788.sal);
    DBMS_OUTPUT.put_line(v_emp7788.hiredate);
end;
/
--------------------------------------------------------------------------------------------------------