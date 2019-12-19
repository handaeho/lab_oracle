-- ex_dept / ex_emp 테이블 생성. (기본 키 - deptno, empno / 외래 키 - deptno)
create table ex_dept (deptno number primary key,
                                dname varchar2(20));
                                
create  table ex_emp (empno number(4) CONSTRAINT pk_ex_emp primary key,
                                ename varchar2(20),
                                deptno number CONSTRAINT fk_ex_dept REFERENCES ex_dept(deptno));

/* ex_dept 테이블에 레코드가 없는 경우                                
 insert into ex_emp VALUES (1001, '오쎔', 10); 
 부모키 없어서 안됨 (무결성 제약조건 위반)
 ex_emp에는 ex_dept 테이블에 생성되어 있지 않는 부서 번호는 insert 불가. */
 
insert into ex_emp (empno,ename)
VALUES (1001, '오쌤'); -- 이것은 가능. deptno가 null이기 때문.
 
insert into ex_dept
VALUES (10, '개발팀');
 
insert into ex_dept
VALUES (20, '분석팀');
 
insert into ex_emp
VALUES (2001, '홍길동', 10);
 
insert into ex_emp
VALUES (2002, '스콧', 20);

select * from ex_emp, ex_dept;

commit;




