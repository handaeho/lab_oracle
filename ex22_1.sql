/*
- 변수 (variable) : 프로그램에서 필요 데이터(값)을 저장하는 공간.
- 상수 (constant) : 값이 한 번 저장되면 변경 불가한 변수.
- 리터럴 (literal) : 프로그램에서 사용되는 고정된 값.
*/
------------------------------------------------------------------------------------------------------------
-- EX
declare 
    var1 NUMBER := 1; --> var1 = 변수
    var2 varchar2(20) := 'abc';  --> var2 = 변수
    const1 CONSTANT number := 3.14; --> const1 = 상수, 선언과 동시에 초기화 필요.
begin
    var1 := 2;
    var2 := '가나다'; 
end;
/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT ON;

declare
    v_num number DEFAULT 0; -->변수는 선언과 동시에 초기화 가능.
begin
    DBMS_OUTPUT.PUT_LINE('v_num = ' || v_num);
end;
/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT ON;
declare
    v_num1 number := 10;
    v_num2 number not null := 20;
begin
    v_num1 := null; --> null 가능함.
   -- v_num2 := null; --> null 불 가능함.
end;
/
------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT ON;

declare 
    v_sal number; -- 급여 저장 변수 선언
begin
    select sal into v_sal from emp where empno = 7788; 
    --emp 테이블에서 7788 사원의 급여 검색 후 v_sal에 저장.
    DBMS_OUTPUT.put_line('급여는 ' || v_sal);
end;
/
------------------------------------------------------------------------------------------------------------
-- 사번을 입력 받아 이름과 부서번호 검색해 출력.
accept p_empno prompt 'What is your number?';

declare
    v_empno number := &p_empno; 
    v_deptno number;
    v_name varchar2(20); 
begin 
    select ename into v_name from emp where empno = v_empno;
    select deptno into v_deptno from emp where empno = v_empno;
    DBMS_OUTPUT.PUT_LINE('deptno is '  || v_deptno || 'name is' || v_name);
end;
/
------------------------------------------------------------------------------------------------------------
-- 사번을 입력 받아 해당 직원 총 급여 출력
accept p_empno prompt 'What is your number?';

declare
    v_empno number := &p_empno; 
    v_deptno number;
    v_name varchar2(20);
    v_sal number;
    v_comm number;
    v_tosal number;
begin 
    select ename, deptno, sal, comm into v_name, v_deptno, v_sal, v_comm 
    from emp 
    where empno = v_empno;
    
    if(v_comm is null) 
    then v_comm := 0;
    end if;
    
    v_tosal := v_sal + v_comm;
    
    DBMS_OUTPUT.PUT_LINE(' deptno is '  || v_deptno || ' name is ' || v_name || ' total sal is ' || v_tosal);
end;
/
------------------------------------------------------------------------------------------------------------