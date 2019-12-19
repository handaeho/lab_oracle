-- ���� ���� 2
/* create table ���̺� �� ( �÷��̸�1 ������Ÿ�� constraint ���������̸� �������ǳ���,
                                    �÷��̸�2 ������Ÿ�� constraint ���������̸� �������ǳ���,
                                    ... );   
                                    
OR

create table ���̺� �� ( �÷��̸�1 ������Ÿ��,
                                �÷��̸�2 ������Ÿ��,
                                ...,
                                constraint ���������̸� �������ǳ���(�÷� �Ǵ� ���̺� ��),
                                constraint ���������̸� �������ǳ���(�÷� �Ǵ� ���̺� ��),
                                ... );
                                *** ���� ������ �̸��� �������� ���� ���� �ϱ� ������ ������ constraint�� ������ ����.
                                *** ��, �� ��������� 'NOT NULL ���� ����'�� ��� �� �� ����. ***
                                *** �� ���� ����� ��� ����. ***
*/
create table ex8 (col1 number,
                        col2 number,
                        CONSTRAINT uq_ex8 unique (col2),
                        CONSTRAINT pk_ex8 PRIMARY key (col1));
                        
-- create table ex9 (col1 varchar2(10),
--                        CONSTRAINT nn_ex9 not null (col1)); -- �Ұ���.
------------------------------------------------------------------------------------------------------------
create table ex_emp2 ( empno number CONSTRAINT pk_ex_emp2 PRIMARY KEY,
                                ename varchar2(20),
                                deptno number(2),
                                CONSTRAINT fk_ex_dept2 FOREIGN KEY (deptno) REFERENCES ex_dept (deptno));
------------------------------------------------------------------------------------------------------------
--�ϳ��� ���̺��� �� �� �̻��� �÷��� ��� �ϳ��� �⺻ Ű�� ����
create table ex9 (col1 number,
                        col2 varchar2(20),
                        CONSTRAINT pk_ex9 PRIMARY KEY (col1,col2));
                        
insert into ex9 VALUES (1, 'a');

insert into ex9 VALUES (1,'b');

insert into ex9 VALUES (2,'a');

-- insert into ex9 VALUES (100, null); - �Ұ���. primary key�� ������ ���տ��� null �Ұ�.
------------------------------------------------------------------------------------------------------------
insert into ex_dept VALUES (30,'�λ���');
------------------------------------------------------------------------------------------------------------
-- INSERT & SELECT - �ٸ� ���̺��� select ����� insert�Ѵ�.
insert into ex_emp2 (empno, ename, deptno)
select empno, ename, deptno from emp;

select * from ex_emp2;

select * 
from ex_emp2 e, ex_dept d 
where e.deptno = d.deptno 
order by d.deptno;
------------------------------------------------------------------------------------------------------------
-- ���̺� �����ϱ� : ���̺� ���� ��, �ٸ� ���̺��� ������ date�� �״�� ��������.
-- create ~ as select
create table ex_emp3
as select * from emp;

select * from ex_emp3;

create table ex_emp4
as select * from emp where deptno = 10; -- ������ ���� ��� ����.

select * from ex_emp4;

create table ex_emp5
as select * from emp where 1 !=1;  -- ������ �׻� Ʋ���� �־ ���ڵ� ���� ����.

select * from ex_emp5;  -- �÷� ���� ������ �ƹ� ���ڵ嵵 ���� ���̺��� ���������.
------------------------------------------------------------------------------------------------------------
