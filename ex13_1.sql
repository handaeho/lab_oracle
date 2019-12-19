-- ���� ���� (Constraint)
------------------------------------------------------------------------------------
-- Constraint Cheak
select constraint_name, constraint_type, table_name
from user_constraints;
------------------------------------------------------------------------------------
/* Constraint ����
1) Not Null - �ݵ�� ���� �ʿ���.
2) Unique - �ߺ� �� ��� �Ұ�.
3) Primary Key - �⺻ Ű. ���̺��� ������ 1���� ���ڵ� �˻� ������ �÷�. Null & �ߺ� X.
4) Foreign Key - �ܺ� Ű. ���踦 �ΰ� �ִ� �ٸ� ���̺��� �⺻ Ű.
5) Cheak - condition üũ�ϴ� ���� ����.(ex) ���� �÷��� ���� 0 �̻��̾�� �Ѵ�.)
6) Default - �÷��� �⺻ ���� ����. (insert ���� �ʾƵ� �ڵ����� �����Ǵ� �� ����)
*/
------------------------------------------------------------------------------------
create table ex3 (col_1 number unique,
                        col_2 varchar2(20) not null);
------------------------------------------------------------------------------------
insert into ex3 (col_1, col_2)
VALUES (1, 'aaa');

-- insert into ex3 (col_1, col_2) 
-- VALUES (1, 'bbb');  -- col_1�� unique�ϴٴ� '���Ἲ ��������'�� ����. ����.
------------------------------------------------------------------------------------
insert into ex3 (col_2)
VALUES ('bbb');

-- insert into ex3 (col_1)
-- VALUES (10); -- col_2���� Null �Ұ�. ����.
------------------------------------------------------------------------------------
commit;
------------------------------------------------------------------------------------
-- ���̺� ���� ��, �������ǿ� �̸� �ο�. CONSTRAINT �������� �̸� ��������
create table ex4 (col1 number CONSTRAINT ex4_unique unique,
                        col2 varchar2(20) CONSTRAINT ex4_nn not null);
                        
create table ex5 (col1 number constraint ex5_pri primary key,
                        col2 varchar2(10));
                        
desc ex5;

insert into ex5 
VALUES (1, 'abc');

commit;
------------------------------------------------------------------------------------
create table ex6 (col varchar2(20) CONSTRAINT ck_ex6 CHECK(length(col) >=8));

desc ex6;

insert into ex6 
VALUES (12345678);

------------------------------------------------------------------------------------       
                
