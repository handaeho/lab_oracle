-- 이름을 입력받아 사번, 이름, 부서번호를 출력.
set SERVEROUTPUT on;

accept p_ename prompt 'What is your name?';

declare

    v_ename emp.ename%type := upper('&p_ename'); 
    v_empno emp.empno%type; 
    v_deptno emp.deptno%type;

begin 
    
    select ename, empno, deptno into v_ename, v_empno, v_deptno
    from emp 
    where ename = v_ename;
    
    DBMS_OUTPUT.PUT_LINE(' empno is ' || v_empno || ' deptno is '  || v_deptno || ' name is ' || v_ename);
end;
/
------------------------------------------------------------------------------------------------------------
-- 이름 입력받아 emp, dept 테이블을 사용해 'x는 y의 z 부서에서 근무합니다.' 형식으로 출력.
set SERVEROUTPUT on;

accept p_ename prompt 'What is your name?';

declare

    v_ename emp.ename%type := upper(trim('&p_ename'));
    v_deptno emp.deptno%type;
    v_dname dept.dname%type;
    v_loc dept.loc%type;

begin 
    
    select e.ename, e.deptno, d.dname, d.loc into v_ename, v_deptno, v_dname, v_loc
    from emp e , dept d 
    where e.ename = v_ename and e.deptno = d.deptno;
    
    DBMS_OUTPUT.PUT_LINE(v_ename || ' 은/는 ' || v_loc || ' 의 ' || v_dname || ' 에서 근무합니다. ');
end;
/
------------------------------------------------------------------------------------------------------------