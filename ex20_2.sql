-- Sequence :  어떤 규칙에 맞는 연속된 숫자들을 자동으로 생성하는 객체.
-- 목적
select max(empno) from emp;

create SEQUENCE seq1;

select seq1.nextval from dual; -- 실행 마다 값이 연속적으로 1씩 증가. 단 , 실행시 증가 된 값을 되돌릴 수 없음.

 -- insert into ex2 (e_id, ex_text) VALUES (null, 'aabbcc'); -- 기본키에 널이기 때문에 불가능
 insert into ex2 (e_id, ex_text) VALUES (seq1.nextval, 'aabbcc'); -- 실행 할때마다 id가 1씩 증가해 삽입됨.
 
 