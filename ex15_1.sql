-- 제약 조건 2
/* create table 테이블 명 ( 컬럼이름1 데이터타입 constraint 제약조건이름 제약조건내용,
                                    컬럼이름2 데이터타입 constraint 제약조건이름 제약조건내용,
                                    ... );   
                                    
OR

create table 테이블 명 ( 컬럼이름1 데이터타입,
                                컬럼이름2 데이터타입,
                                ...,
                                constraint 제약조건이름 제약조건내용(컬럼 또는 테이블 명),
                                constraint 제약조건이름 제약조건내용(컬럼 또는 테이블 명),
                                ... );
                                *** 제약 조건의 이름과 내용으로 각각 설정 하기 때문에 정해진 constraint의 순서는 없다.
                                *** 단, 이 방법에서는 'NOT NULL 제약 조건'은 사용 할 수 없다. ***
                                *** 두 개를 섞어서도 사용 가능. ***
*/
create table ex8 (col1 number,
                        col2 number,
                        CONSTRAINT uq_ex8 unique (col2),
                        CONSTRAINT pk_ex8 PRIMARY key (col1));
                        
-- create table ex9 (col1 varchar2(10),
--                        CONSTRAINT nn_ex9 not null (col1)); -- 불가능.
------------------------------------------------------------------------------------------------------------
create table ex_emp2 ( empno number CONSTRAINT pk_ex_emp2 PRIMARY KEY,
                                ename varchar2(20),
                                deptno number(2),
                                CONSTRAINT fk_ex_dept2 FOREIGN KEY (deptno) REFERENCES ex_dept (deptno));
------------------------------------------------------------------------------------------------------------
--하나의 테이블에서 두 개 이상의 컬럼을 묶어서 하나의 기본 키로 지정
create table ex9 (col1 number,
                        col2 varchar2(20),
                        CONSTRAINT pk_ex9 PRIMARY KEY (col1,col2));
                        
insert into ex9 VALUES (1, 'a');

insert into ex9 VALUES (1,'b');

insert into ex9 VALUES (2,'a');

-- insert into ex9 VALUES (100, null); - 불가능. primary key로 지정된 집합에는 null 불가.
------------------------------------------------------------------------------------------------------------
insert into ex_dept VALUES (30,'인사팀');
------------------------------------------------------------------------------------------------------------
-- INSERT & SELECT - 다른 테이블의 select 결과를 insert한다.
insert into ex_emp2 (empno, ename, deptno)
select empno, ename, deptno from emp;

select * from ex_emp2;

select * 
from ex_emp2 e, ex_dept d 
where e.deptno = d.deptno 
order by d.deptno;
------------------------------------------------------------------------------------------------------------
-- 테이블 복사하기 : 테이블 생성 시, 다른 테이블의 구조와 date를 그대로 가져오자.
-- create ~ as select
create table ex_emp3
as select * from emp;

select * from ex_emp3;

create table ex_emp4
as select * from emp where deptno = 10; -- 복사의 조건 명시 가능.

select * from ex_emp4;

create table ex_emp5
as select * from emp where 1 !=1;  -- 조건을 항상 틀리게 주어서 레코드 복사 못함.

select * from ex_emp5;  -- 컬럼 명은 있지만 아무 레코드도 없는 테이블이 만들어진다.
------------------------------------------------------------------------------------------------------------
