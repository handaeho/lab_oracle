-- Sequence :  � ��Ģ�� �´� ���ӵ� ���ڵ��� �ڵ����� �����ϴ� ��ü.
-- ����
select max(empno) from emp;

create SEQUENCE seq1;

select seq1.nextval from dual; -- ���� ���� ���� ���������� 1�� ����. �� , ����� ���� �� ���� �ǵ��� �� ����.

 -- insert into ex2 (e_id, ex_text) VALUES (null, 'aabbcc'); -- �⺻Ű�� ���̱� ������ �Ұ���
 insert into ex2 (e_id, ex_text) VALUES (seq1.nextval, 'aabbcc'); -- ���� �Ҷ����� id�� 1�� ������ ���Ե�.
 
 