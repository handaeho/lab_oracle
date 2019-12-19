-- 제약 조건 (Constraint)
------------------------------------------------------------------------------------
-- Constraint Cheak
select constraint_name, constraint_type, table_name
from user_constraints;
------------------------------------------------------------------------------------
/* Constraint 종류
1) Not Null - 반드시 값이 필요함.
2) Unique - 중복 값 허용 불가.
3) Primary Key - 기본 키. 테이블에서 유일한 1개의 레코드 검색 가능한 컬럼. Null & 중복 X.
4) Foreign Key - 외부 키. 관계를 맺고 있는 다른 테이블의 기본 키.
5) Cheak - condition 체크하는 제약 조건.(ex) 연령 컬럼의 값은 0 이상이어야 한다.)
6) Default - 컬럼의 기본 값을 설정. (insert 하지 않아도 자동으로 설정되는 값 지정)
*/
------------------------------------------------------------------------------------
create table ex3 (col_1 number unique,
                        col_2 varchar2(20) not null);
------------------------------------------------------------------------------------
insert into ex3 (col_1, col_2)
VALUES (1, 'aaa');

-- insert into ex3 (col_1, col_2) 
-- VALUES (1, 'bbb');  -- col_1이 unique하다는 '무결성 제약조건'에 위배. 오류.
------------------------------------------------------------------------------------
insert into ex3 (col_2)
VALUES ('bbb');

-- insert into ex3 (col_1)
-- VALUES (10); -- col_2번은 Null 불가. 오류.
------------------------------------------------------------------------------------
commit;
------------------------------------------------------------------------------------
-- 테이블 생성 시, 제약조건에 이름 부여. CONSTRAINT 제약조건 이름 제약조건
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
                
