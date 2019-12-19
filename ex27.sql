/* �ݺ���

(1) LOOP
loop
    �ݺ��� ����;
    exit when ���ǽ�;
end loop;

(2) While Loop
while ���ǽ� loop
    ���ǽ��� true�϶� �ݺ��� ����;
end loop;

(3) For Loop
for ���� ���۰�..�������� loop
    �ݺ��� ����;
end loop;

*/
--------------------------------------------------------------------------------------------------------
set serveroutput on;

declare
    v_num number := 1;
begin
    loop
        -- v_num�� ���� ���
        dbms_output.put_line('v_num = ' || v_num);  
        -- v_num�� ���� 1 ����
        v_num := v_num + 1;
        -- loop ���� ����
        exit when v_num > 5;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
-- loop�� ����� ������ 2�� ���
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
ACCEPT x PROMPT '���?';

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
-- while�������� Exit Ȱ��.
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
-- for�������� Exit Ȱ��.
declare
begin
    for i in 1..10 loop
        DBMS_OUTPUT.PUT_LINE (' i = ' || i);
        exit when i = 5;
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
-- for loop ���� ����
declare
begin
    for i in REVERSE 1..10 loop
    DBMS_OUTPUT.PUT_LINE (' i = ' || i);
    end loop;
end;
/
--------------------------------------------------------------------------------------------------------
--�ݺ��� (loop / while / for)���� 
-- 1) exit when ���ǽ� : ���ǽ��� �����ϴ� ��쿡 �ݺ��� ����.
-- 2) continue when ���ǽ� : ���ǽ��� �����ϴ� ��쿡 �ݺ����� ���ۺκ����� �ǵ��ư�.
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