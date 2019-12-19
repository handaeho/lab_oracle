-- ���� ����(constraint)
-- ������ ����� ������ ���̺�鿡 ����� �������� Ȯ��
select constraint_name, constraint_type, table_name
from user_constraints;

select table_name from user_tables;

-- ���� ����
-- not null: �ݵ�� ���� �־�� ��
-- unique: �ߺ��� ���� ����� �� ����
-- primary key: ����Ű. ���̺��� ������ �Ѱ��� ��(���ڵ�)�� �˻��� �� �ִ� �÷�
-- foreign key: �ܷ�Ű. �ܺ�Ű. ���踦 �ΰ� �ִ� �ٸ� ���̺��� PK
-- check: ����(condition)�� üũ�ϴ� ���� ����.
-- default: �÷��� �⺻��(insert���� �ʾƵ� �ڵ����� ����Ǵ� ��)�� ����

-- ���̺� �̸�: ex03
-- �÷�: col1 - number, unique
--       col2 - varchar2(20), not null
create table ex03 (
    col1 number unique,
    col2 varchar2(20) not null
);

desc ex03;

insert into ex03 (col1, col2)
values (1, 'aaa');  --  insert ����

insert into ex03 (col1, col2) 
values (1, 'bbb'); -- unique ���� ���� ����: insert ����

insert into ex03 (col2)
values ('bbb');
select * from ex03;

insert into ex03 (col1)
values (10);
commit;


-- ���̺� ���� �� ���� ���ǿ� �̸��� �ִ� ���
create table ex04 (
    col1 number,
    col2 varchar2(20)
);