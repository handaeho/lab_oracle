/*
커서(Cursor) = PL/SQL에서 SQL 문장 처리 정보를 저장하는 메모리 공간.
1) 명시적 커서(Explicit cursor) : 개발자가 직접 이름을 선언하고 사용함.
2) 묵시적 커서 (Implicit cursor) : 별 다른 선언 없이 사용함.

명시적 커서의 순서 : 선언 -> open -> fetch -> close
*/
--------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
--------------------------------------------------------------------------------------------------------------
select * from dept;

declare
    v_dept dept%rowtype;
begin
    select * into v_dept from dept where deptno =10;
    
-- 오라클 내부에서 묵시적 커서가 자동으로 생성됨.    
    DBMS_OUTPUT.put_line(v_dept.deptno); 
end;
/
--------------------------------------------------------------------------------------------------------------
--  select ~ into ~ 구문은 한 개 이상의 row가 select되는 경우는 사용 블가.
-- 명시적 커서는 select의 결과 row의 갯수에 상관없이 사용 가능.
declare
-- 명시적 커서 선언 -> cusor 커서이름 is (SQL 문장);
    cursor my_cursor is (
        select * from dept where deptno =10);
        
    v_row dept%rowtype; -- 커서의 데이터를 fetch 할 때 사용할 변수
begin
-- 커서 open(열기, 접근)
    open my_cursor;
    
-- 커서 fetch(데이터 분석)
    fetch my_cursor into v_row;
    
    DBMS_OUTPUT.PUT_LINE(v_row.deptno || ' / ' || v_row.dname || ' / ' || v_row.loc);
    
-- 커서 close(닫기)
    close my_cursor;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 결과 행이 1개인 명시적 커서
declare
-- 커서 선언
    cursor sel_emp is (
        select * from emp where empno = 7788);
        
        v_row emp%rowtype; -- 커서 결과 fetch 할 변수
begin
-- 커서 open
    open sel_emp;

-- 커서 fetch
    fetch sel_emp into v_row;
    DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename);
-- 커서 close
    close sel_emp;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 결과 행이 여러개인 명시적 커서
declare
-- 커서 선언
    cursor sel_dept is (
        select * from dept);
        
        v_row dept%rowtype; -- 커서 결과 fetch 할 변수
begin
-- 커서 open
    open sel_dept;

-- 커서 fetch
-- 여러 행의 데이터 리턴시에는 loop 사용.
    loop
        fetch sel_dept into v_row;
        -- 커서에서 더이상 읽을 데이터가 없을때 루프 종료
        exit when sel_dept%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.deptno || ' / ' || v_row.dname || ' / ' || v_row.loc);
    end loop;

-- 커서 close
    close sel_dept;
end;
/
--------------------------------------------------------------------------------------------------------------
-- emp 테이블에서 부서 번호가 30번인 직원들의 사번, 이름, 급여를 출력
declare
-- 커서 선언
    cursor ex_emp is (
        select * from emp where deptno = 30);
        
        v_row emp%rowtype; -- 커서 결과 fetch 할 변수
begin
-- 커서 open
    open ex_emp;

-- 커서 fetch
-- 여러 행의 데이터 리턴시에는 loop 사용.
    loop
        fetch ex_emp into v_row;
        -- 커서에서 더이상 읽을 데이터가 없을때 루프 종료
        exit when ex_emp%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal || ' / ' || v_row.deptno);
    end loop;

-- 커서 close
    close ex_emp;
end;
/
--------------------------------------------------------------------------------------------------------------
declare
-- 커서 선언
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 10);
        
    type my_record is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type);
         
        v_row my_record; -- 커서 결과 fetch 할 변수
begin
-- 커서 open
    open my_cursor;

-- 커서 fetch
--    loop
--        fetch my_cursor into v_row;
--        -- 커서에서 더이상 읽을 데이터가 없을때 루프 종료
--        exit when my_cursor%notfound;
--        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal);
--    end loop;

-- 위의 loop문을 while로 바꾸었을때. 데이터를 found 했다면 반복
    fetch my_cursor into v_row;
    while my_cursor%found loop
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal);
        fetch my_cursor into v_row;
    end loop; -- fetch을 통해 메모리의 기존 데이터를 읽어 온 후, 
                    --found로 데이터를 찾고, 찾은 그 데이터를 다시 메모리에 fetch.
                    -- 따라서 fetch문은 while문 앞에 하나, 안에 하나씩 작성해야만 한다.

-- 커서 close
    close my_cursor;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 명시적 커서를 for loop에서 사용할 때는 open / fetch / close 과정이 자동으로 수행됨. 따라서 필요 X.
-- for 변수 in 커서이름 loop ~ end loop;
declare
-- 커서 선언
    cursor my_cursor is (
        select * from dept);

begin
    for row in my_cursor loop
        DBMS_OUTPUT.PUT_LINE(row.deptno || ' / ' || row.dname || ' / ' || row.loc);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 명시적 커서 & for loop를 사용해 20번 부서의 직원 사번, 이름, 급여 출력
declare
-- 커서 선언
    cursor my_cursor is (
        select empno, ename, sal from emp where deptno = 20);

begin
    for row in my_cursor loop
        DBMS_OUTPUT.PUT_LINE(row.empno || ' / ' || row.ename || ' / ' || row.sal || ' / ' || row.deptno);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 파라미터(매개변수)를 갖는 커서
-- cursor 커서이름(변수 타입) is SQL 문장;
declare
    v_avg number;
    
    CURSOR my_cursor(p_avg number) is
        select ename from emp where sal < p_avg;
begin
-- 전체 직원 급여 평균 구하기
    select avg(sal) into v_avg from emp;
    DBMS_OUTPUT.PUT_LINE(v_avg);
    
-- 파라미터를 갖는 커서를 open, fetch, close (for문으로 한 번에)
    for row in my_cursor(v_avg) loop
        DBMS_OUTPUT.PUT_LINE(row.ename);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 1) 전체 직원의 급여 평균보다 적은 급여의 직원 이름 출력.
declare
    CURSOR ex1_emp is (
        select * from emp where sal < (select avg(sal) from emp)); 
        
         v_row emp%rowtype;
begin 
    open ex1_emp;
    
    loop
        fetch ex1_emp into v_row;
        exit when ex1_emp%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal || ' / ' || v_row.deptno);
    end loop;
    
    close ex1_emp;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 2) 10번 부서에서 10번 부서 급여 평균보다 적은 급여 받는 직원 이름 출력.
declare
    CURSOR ex2_emp is (
        select * from emp where deptno = 10 and sal < (select avg(sal) from emp where deptno = 10)); 
        
         v_row emp%rowtype;
begin 
    open ex2_emp;
   
    loop
        fetch ex2_emp into v_row;
        exit when ex2_emp%notfound;
        DBMS_OUTPUT.PUT_LINE(v_row.empno || ' / ' || v_row.ename || ' / ' || v_row.sal || ' / ' || v_row.deptno);
    end loop;
    
    close ex2_emp;
end;
/
---------------------OR---------------------
declare
    cursor my_cursor is
        select deptno, ename from emp where deptno =10 and 
                                                                sal <(select avg(sal) from emp where deptno =10); 

begin
    for row in my_cursor loop
        DBMS_OUTPUT.PUT_LINE(row.ename || ' / ' ||row.deptno);
    end loop;
end;
/
---------------------OR---------------------
declare
    cursor my_cursor(p_deptno emp.deptno%type) is -- my_cursor(부서번호)
        SELECT deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = p_deptno) and deptno = p_deptno;
begin
    for row in my_cursor(10) loop -- 여기에서 my_cursor(부서번호)
        DBMS_OUTPUT.PUT_LINE(row.ename || ' / ' ||row.deptno);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------------
-- 3) 각 부서에서 그 부서의 급여 평균보다 적은 급여 받는 직원 이름과 부서번호 출력.
declare
    cursor my_cursor(p_deptno emp.deptno%type) is -- my_cursor(부서번호)
        SELECT deptno, ename from emp
        where sal < (select avg(sal) from emp where deptno = p_deptno) and deptno = p_deptno;
begin
    for i in 1..30 loop
        for row in my_cursor(i) loop -- 여기에서 my_cursor(부서번호)
            DBMS_OUTPUT.PUT_LINE(row.ename || ' / ' ||row.deptno);
        end loop;
    end loop;
end;
/