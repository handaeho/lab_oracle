-- ���ڵ� ���� & ����
select * from ex_emp3;

-- ex_emp3���� 7369 ��� �޿��� 2000���� ����
-- ����!  where ���� �����Ǹ� ��� ���ڵ带 �����Ѵ�.
update ex_emp3 
set sal =2000 
where empno = 7369;

-- 1�� Ʃ�ø� ����.
update ex_emp3 
set deptno = null 
where empno = 7369;

-- rollback = commit ������ ���·� �ǵ���.
rollback;

-- ���ڵ� ����
delete 
from ex_emp3 
where deptno =10;

-- update ���� ����
update ex_emp3 
set comm =100 
where deptno = 20;

-- update �������� �̿�
update ex_emp3 
set sal = sal*2 
where sal <= (select avg(sal) from ex_emp3);

