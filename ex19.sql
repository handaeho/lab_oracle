-- Session, Transaction, Lock
/* 
1) DML : 데이터 조작 언어 = INSERT / UPDATE / DELETE
2) DDL : 데이터 정의 언어 = CREATE / ALTER / TRUNCATE / DROP
3) DQL : 데이터 쿼리(질의) 언어 = SELECT
4) TCL : 트랜젝션 관리 언어 = COMMIT / ROLLBACK
*/
select * from dept2;

update dept2
set loc = '서울 seoul'
where deptno = 50;

insert into dept2 VALUES(90, 'itwill', 'gangnam');

commit;