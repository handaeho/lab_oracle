-- ex_dept / ex_emp ���̺� ����. (�⺻ Ű - deptno, empno / �ܷ� Ű - deptno)
create table ex_dept (deptno number primary key,
                                dname varchar2(20));
                                
create  table ex_emp (empno number(4) CONSTRAINT pk_ex_emp primary key,
                                ename varchar2(20),
                                deptno number CONSTRAINT fk_ex_dept REFERENCES ex_dept(deptno));

/* ex_dept ���̺� ���ڵ尡 ���� ���                                
 insert into ex_emp VALUES (1001, '����', 10); 
 �θ�Ű ��� �ȵ� (���Ἲ �������� ����)
 ex_emp���� ex_dept ���̺� �����Ǿ� ���� �ʴ� �μ� ��ȣ�� insert �Ұ�. */
 
insert into ex_emp (empno,ename)
VALUES (1001, '����'); -- �̰��� ����. deptno�� null�̱� ����.
 
insert into ex_dept
VALUES (10, '������');
 
insert into ex_dept
VALUES (20, '�м���');
 
insert into ex_emp
VALUES (2001, 'ȫ�浿', 10);
 
insert into ex_emp
VALUES (2002, '����', 20);

select * from ex_emp, ex_dept;

commit;




