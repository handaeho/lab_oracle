-- 레코드 & 컬렉션
/*
레코드 : 데이터 타입이 서로 다른 여러개의 데이터를 저장 할 때 사용.
1) 레코드 정의 방법 
 type 레코드이름 is record (
    변수이름 변수타입,
    변수이름 변수타입,
    변수이름 변수타입,
    ... );
    
2) 레코드에 값을 저장
 레코드.필드 := 값;
*/
---------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
---------------------------------------------------------------------------------------------------
declare
    -- 레코드 정의
    type rec_dept is record (
        deptno number,
        dname varchar2(20),
        loc varchar2(20));
        
        -- 레코드명은 변수 선언 시, 사용.
        v_dept_row rec_dept;
begin
    -- 레코드 변수값 저장
    v_dept_row.deptno := 99;
    v_dept_row.dname := 'ITWILL';
    v_dept_row.loc := 'SEOUL';
    
    -- 레코드 변수 값 읽어올 때는 레코드변수.필드
    DBMS_OUTPUT.PUT_LINE('번호 = ' || v_dept_row.deptno);
    DBMS_OUTPUT.PUT_LINE('이름 = ' || v_dept_row.dname);
    DBMS_OUTPUT.PUT_LINE('위치 = ' || v_dept_row.loc);
end;
/
---------------------------------------------------------------------------------------------------
select * from dept2;

declare
    type rec_dept is record (
        deptno  dept2.deptno%type,
        dname   dept2.dname%type,
        loc     dept2.loc%type
    );
    
    v_row rec_dept;
begin
    v_row.deptno := 11;
    v_row.dname := '데이터베이스';
    v_row.loc := 'Seoul';
    
-- 일반적인 INSERT.
--    insert into dept2
--    VALUES (v_row.deptno,
--                v_row.deptno,
--                v_row.loc);

-- 테이블에 레코드 타입 사용한 INSERT.  
    insert into dept2 
    VALUES v_row; -- 위의 방법보다 값에 레코드 자체를 넣어주면 훨씬 간단.

-- 일반적인 UPDATE.
--    update dept2 
--    set deptno = 20, 
--         dname = '데이터베이스', 
--         loc = '서우우울' 
--    where deptno = 11; 

-- 레코드 타입 변수 사용한  UPDATE.
    v_row.deptno := 99;
    v_row.dname := '데이터베이스';
    v_row.loc := '서우우울';
    
    update dept2
    set row = v_row
    where deptno =11;
    
    DBMS_OUTPUT.PUT_LINE('번호 = ' || v_row.deptno);
    DBMS_OUTPUT.PUT_LINE('이름 = ' || v_row.dname);
    DBMS_OUTPUT.PUT_LINE('위치 = ' || v_row.loc);
end;
/
---------------------------------------------------------------------------------------------------
declare
    -- row 타입 참조 변수 선언.
    v_row1 dept%rowtype;
    -- 테이블 구조(컬럼명, 타입)와 똑같은 레코드 타입.
begin 
    v_row1.deptno := 22;
    v_row1.dname := 'ABC';
    v_row1.loc := 'KOREA';
    
    insert into dept2
    VALUES v_row1;

end;
/
---------------------------------------------------------------------------------------------------
select * from emp;

-- 레코드 이용한 SELECT
declare
    -- 1) 테이블의 '모든 컬럼을 검색'하는 경우, 
    -- 레코드를 직접 정의하는 것보다 %rowtype 참조를 사용하는 것이 편리하다. 
    v_emp_row1 emp%rowtype;
    
    -- 2) 테이블의 '특정 컬럼만을 검색'하거나 '두개 이상의 테이블을 조인'하는 경우,
    -- 사용자가 레코드를 직접 정의하는 것이 편리하다.
    type rec_emp is record (
        empno emp.empno%type,
        ename emp.ename%type,
        job emp.job%type);
        
        v_emp_row2 rec_emp;
begin
    -- 1) 테이블 전체 컬럼 검색
    select * into v_emp_row1 
    from emp 
    where empno = 7788;
    dbms_output.put_line(v_emp_row1.empno|| ', ' || v_emp_row1.ename);
    
    -- 2) 테이블 일부 컬럼 검색
    select empno, ename, job into v_emp_row2
    from emp
    where empno = 7839;
    dbms_output.put_line(v_emp_row2.empno|| ', ' || v_emp_row2.ename || ', ' || v_emp_row2.job);

end;
/

-- emp 테이블과 dept 테이블에서 사번, 이름, 급여, 부서명, 부서위치를 저장하는 레코드를 만들고
-- '조인'을 이용해 scott의 정보를 출력해라.
declare
    type emp_dept is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type,
        dname dept.dname%type,
        loc dept.loc%type);
        
        v_emp_dept emp_dept;
begin
    select e.empno, e.ename, e.sal, d.dname, d.loc into v_emp_dept
    from emp e, dept d
    where e.deptno = d.deptno and e.empno = 7788;
    dbms_output.put_line(v_emp_dept.empno|| ', ' || v_emp_dept.ename || ', ' || v_emp_dept.sal 
                                    || ', ' || v_emp_dept.dname || ', '|| v_emp_dept.loc);

end;
/
---------------------------------------------------------------------------------------------------
-- emp 테이블과 salgrade 테이블에서 사번, 이름, 급여, 급여등급을 저장하는 레코드를 만들고
-- '조인'을 이용해 scott의 정보를 출력해라.
declare
    type emp_sal is record (
        empno emp.empno%type,
        ename emp.ename%type,
        sal emp.sal%type,
        grade salgrade.grade%type);
        
        v_emp_sal emp_sal;
begin
    select e.empno, e.ename, e.sal, s.grade into v_emp_sal
    from emp e join salgrade s
    on e.sal between s.losal and s.hisal 
    where e.empno = 7788 ;
    dbms_output.put_line(v_emp_sal.empno|| ', ' || v_emp_sal.ename || ', ' || v_emp_sal.sal 
                                    || ', ' || v_emp_sal.grade);

end;
/
---------------------------------------------------------------------------------------------------
