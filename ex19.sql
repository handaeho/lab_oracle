-- Session, Transaction, Lock
/* 
1) DML : ������ ���� ��� = INSERT / UPDATE / DELETE
2) DDL : ������ ���� ��� = CREATE / ALTER / TRUNCATE / DROP
3) DQL : ������ ����(����) ��� = SELECT
4) TCL : Ʈ������ ���� ��� = COMMIT / ROLLBACK
*/
select * from dept2;

update dept2
set loc = '���� seoul'
where deptno = 50;

insert into dept2 VALUES(90, 'itwill', 'gangnam');

commit;