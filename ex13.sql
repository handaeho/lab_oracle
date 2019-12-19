-- ���̺� ����
create table ex1 (
    ex_id       number,
    ex_text     varchar2(10),
    ex_date     date
);

-- ���̺� ����(�÷� �̸�, ������ Ÿ��, Null ����) Ȯ��
desc ex1;

-- ���̺� ������(���ڵ�) ����(����)
insert into ex1 (ex_id, ex_text, ex_date)
values (1, '�ȳ��ϼ���', sysdate);

-- ���̺� ����� ������(���ڵ�)�� �˻�
select * from ex1;

-- ����� �����͸� DBMS�� ���� ����
commit;

-- DDL(Data Defintion Language): ������ ���� ���
-- create, alter, drop, truncate
-- DDL ����� ������ �Ǹ� �ڵ����� commit�� ��.

-- DML(Data Manpulation Language): ������ ���� ���
-- insert, update, delete
-- DB�� ������ ����ڰ� commit ����� �����ؾ߸� DBMS�� ���������� �ݿ���!

insert into ex1 (ex_id, ex_text)
values (2, 'abc');
select * from ex1;

insert into ex1 (ex_text, ex_id)
values ('�ؽ�Ʈ', 10);
select * from ex1;

-- ���̺��� ��� �÷��� ���� ������ ����
-- insert into �������� �÷� �̸��� ������ �� �ִ�.
-- ��, values�� ���̺��� �÷� ������ ��ġ���Ѽ� ��� ���� �����ؾ� ��!
insert into ex1
values (11, 'data', sysdate);

insert into ex1 values (20); -- values�� ������ �÷��� ������ �ٸ�.
insert into ex1 values(sysdate, 'test', 0); -- values�� ���̺� �÷��� ������ Ÿ���� �ٸ�.

insert into ex1 (ex_text)
values ('����ֳ���?'); -- varchar2(10)�� ������ �� �ִ� ���ڿ� ���̸� �ʰ� 






