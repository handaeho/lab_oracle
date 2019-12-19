-- ���̺� ����
-- ���̺��� �÷� �̸� ����
alter table ex02 rename column ex_id to eid;

-- ���̺��� �÷� ������ Ÿ�� ����
alter table ex02 modify ex_text varchar2(100);

-- ���̺� ���ο� �÷� �߰�
alter table ex02 add ex_date date;

-- ���̺��� �÷� ����
alter table ex02 drop column ex_date;

-- ���̺� �÷��� ���� ���� �߰�
alter table ex02
add constraint pk_ex02 primary key (eid);
-- �÷��� null �Ǵ� �ߺ��� ���� �ִ� ���� PK ������ �� ����.

select * from ex02;

update ex02 set eid = 2 where eid is null;

-- null ���� �÷��� not null ���� ���� �߰�
alter table ex02
add constraint nn_ex02 check (ex_text is not null);

-- �÷��� ������ ���� ���� ���� 
alter table ex02
drop constraint nn_ex02;

desc ex02;

-- ���̺� vs ����� ����
-- ����� ���� create/alter/drop�� system �������� ����
create table ex_test (...);
create user scott2 identified by tiger;

alter table ex_test
rename column a to b;
alter user scott 
identified by tiger account unlock;

drop table ex_test;
drop user scott2;


-- 1.
create table hw_emp
as (select * from emp where 1 != 1);

select * from hw_emp;

-- 2.
alter table hw_emp add etc varchar2(20);
desc hw_emp;

-- 3.
alter table hw_emp modify etc varchar2(100);

-- 4.
alter table hw_emp rename column etc to remark;

-- 5.
insert into hw_emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select * from emp;

select * from hw_emp;

-- 6.
alter table hw_emp add constraint pk_hw_emp primary key (empno);

-- 7.
drop table hw_emp;


-- sequence: � ��Ģ�� �´� ���ӵ� ���ڵ��� �ڵ����� ������ �ִ� ��ü
-- ������(sequence)�� ����
select max(empno) from emp;

create sequence seq1;
select seq1.nextval from dual;

insert into ex02(eid, ex_text)
values(seq1.nextval, 'aabbcc');

select * from ex02;





