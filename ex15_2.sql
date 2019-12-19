-- 레코드 수정 & 삭제
select * from ex_emp3;

-- ex_emp3에서 7369 사원 급여를 2000으로 변경
-- 주의!  where 절이 생략되면 모든 레코드를 수정한다.
update ex_emp3 
set sal =2000 
where empno = 7369;

-- 1개 튜플만 수정.
update ex_emp3 
set deptno = null 
where empno = 7369;

-- rollback = commit 이전의 상태로 되돌림.
rollback;

-- 레코드 삭제
delete 
from ex_emp3 
where deptno =10;

-- update 연습 문제
update ex_emp3 
set comm =100 
where deptno = 20;

-- update 서브쿼리 이용
update ex_emp3 
set sal = sal*2 
where sal <= (select avg(sal) from ex_emp3);

