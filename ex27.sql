/* 반복문

(1) LOOP
loop
    반복할 문장;
    exit when 조건식;
end loop;

(2) While Loop
while 조건식 loop
    조건식이 true일때 반복할 문장;
end loop;

(3) For Loop
for 변수 시작값..마지막값 loop
    반복할 문장;
end loop;

*/
--------------------------------------------------------------------------------------------------------
set serveroutput on;

declare
    v_num number := 1;
begin
    loop
        -- v_num의 값을 출력
        dbms_output.put_line('v_num = ' || v_num);  
        -- v_num의 값을 1 증가
        v_num := v_num + 1;
        -- loop 종료 조건
        exit when v_num > 5;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
-- loop를 사용한 구구단 2단 출력
declare
    v_num number := 1;
begin
    loop
        dbms_output.put_line('2 x ' || v_num || ' = ' || (2 * v_num));
        v_num := v_num + 1;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
ACCEPT x PROMPT '몇단?';

declare
    a INT := &x;
    i int;
begin
    for i  in 1..9 
        loop
            DBMS_OUTPUT.PUT_LINE (a || ' * ' || i || ' = ' || a*i);
        end loop;
end;
/
--------------------------------------------------------------------------------------------------------
set serveroutput on;
declare
    x int :=1;
begin
    while x <= 5 
    loop
        dbms_output.put_line(x);
        x := x+1;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
declare
    x int :=1;
    y int :=1;
    z int;
begin
    while x <= 9 loop
        dbms_output.put_line(' ===============');
            while y <= 9 loop
                z := x*y;
                dbms_output.put_line(x || ' * ' || y || ' = ' || z);
                y := y+1;
            end loop;
        y := 1;
        x := x+1;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
declare
    b int;
begin
    for i  in 1..9 loop
        DBMS_OUTPUT.PUT_LINE ('=============');
            for j in 1..9 loop
                b := i*j;
                DBMS_OUTPUT.PUT_LINE (i || ' * ' || j || ' = ' || b);
            end loop;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
-- while문에서의 Exit 활용.
declare
    v number := 1;
begin
    while v < 10 loop
        DBMS_OUTPUT.PUT_LINE (' v = ' || v);
        v := v+1;
        exit when v =5;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
-- for문에서의 Exit 활용.
declare
begin
    for i in 1..10 loop
        DBMS_OUTPUT.PUT_LINE (' i = ' || i);
        exit when i = 5;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
-- for loop 역순 진행
declare
begin
    for i in REVERSE 1..10 loop
    DBMS_OUTPUT.PUT_LINE (' i = ' || i);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
--반복문 (loop / while / for)에서 
-- 1) exit when 조건식 : 조건식을 만족하는 경우에 반복문 종료.
-- 2) continue when 조건식 : 조건식을 만족하는 경우에 반복문의 시작부분으로 되돌아감.
declare
begin
    for i in 1..10 loop
    continue when mod(i,2) = 0;
    dbms_output.put_line(i);
    end loop;
end;
/
---------------- OR -----------------
declare
begin
    for i in 0..4 loop
    dbms_output.put_line(2 * i + 1);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------