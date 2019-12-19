-- 제약 조건(constraint)
-- 접속한 사용자 계정의 테이블들에 적용된 제약조건 확인
select constraint_name, constraint_type, table_name
from user_constraints;

select table_name from user_tables;

-- 제약 조건
-- not null: 반드시 값이 있어야 함
-- unique: 중복된 값이 저장될 수 없음
-- primary key: 고유키. 테이블에서 유일한 한개의 행(레코드)를 검색할 수 있는 컬럼
-- foreign key: 외래키. 외부키. 관계를 맺고 있는 다른 테이블의 PK
-- check: 조건(condition)을 체크하는 제약 조건.
-- default: 컬럼의 기본값(insert하지 않아도 자동으로 저장되는 값)을 설정

-- 테이블 이름: ex03
-- 컬럼: col1 - number, unique
--       col2 - varchar2(20), not null
create table ex03 (
    col1 number unique,
    col2 varchar2(20) not null
);

desc ex03;

insert into ex03 (col1, col2)
values (1, 'aaa');  --  insert 성공

insert into ex03 (col1, col2) 
values (1, 'bbb'); -- unique 제약 조건 위배: insert 실패

insert into ex03 (col2)
values ('bbb');
select * from ex03;

insert into ex03 (col1)
values (10);
commit;


-- 테이블 생성 시 제약 조건에 이름을 주는 방법
create table ex04 (
    col1 number,
    col2 varchar2(20)
);