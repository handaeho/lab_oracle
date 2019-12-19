set SERVEROUTPUT on;

-- 1. dbms_random.value() 함수 이용해서, 주사위 2개를 던졌을 때 나오는 눈을 (x, y) 형식으로 출력하는 
-- PL/SQL을 작성하세요. 주사위 2개의 눈이 같아졌을 때 출력을 멈추세요.
declare
    dice1 number := 0;
    dice2 number := 0;
begin
     loop
        dice1 := trunc(dbms_random.value(1,7));
        dice2 := trunc(dbms_random.value(1,7));
        DBMS_OUTPUT.put_line('dice1 = ' || dice1 || ' / ' || 'dice2 = ' || dice2);
        exit when dice1 = dice2;
    end loop;
end;
/

-- 2.피보나치 수열의 원소 20개를 출력하는 PL/SQL을 작성하세요.
-- 이웃하는 피보나치 수의 비율은 황금비(golden ratio)라 불리는 수 1.61803...에 수렴함을 보이세요.
declare
    f1 number:= 0;
    f2 number:= 1;
    v_result number :=0;
begin
    for i in 2..20 loop
        v_result := f1 + f2;
        f1 :=f2;
        f2 := v_result;
        
        dbms_output.put(v_result);
        dbms_output.new_line;
        dbms_output.put_line('황금비율 : '|| f1 /f2);
    end loop;

end;
/

-- 3. 순열(Permutation), 조합(Combination)
-- a, b, c 3개의 문자 중에서

-- (1) 중복을 허락해서 2개의 문자를 순서대로 나열해서 출력
--    (결과) aa, ab, ac, ba, bb, bc, ca, cb, cc
declare
    type arr is varray(3) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c');
    
    for i in 1..v_arr.count loop
        for j in 1..v_arr.count loop
            dbms_output.put(v_arr(i) || v_arr(j) || ' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (2) 중복을 허락하지 않고 2개의 문자를 순서대로 나열해서 출력
--    (결과) ab, ac, ba, bc, ca, cb 
declare
    type arr is varray(3) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c');
    for i in 1..v_arr.count loop
        for j in i+1..v_arr.count loop
                dbms_output.put(v_arr(i) || v_arr(j) ||' ');
        end loop;
        for j in REVERSE i+1..v_arr.count loop
                dbms_output.put(v_arr(j) || v_arr(i) ||' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (3) 중복을 허락하지 않고 2개의 문자를 선택해서 출력(순서는 중요하지 않음)
--    (결과) ab, ac, bc
declare
    type arr is varray(3) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c');
    for i in 1..v_arr.count loop
        for j in i+1..v_arr.count loop
                dbms_output.put(v_arr(i) || v_arr(j) ||' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (4) 2개의 문자(중복 가능)를 출력(순서는 중요하지 않음)
--    (결과) aa, ab, ac, bb, bc, cc
declare
    type arr is varray(3) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c');
    
    for i in 1..v_arr.count loop
        for j in i..v_arr.count loop
            dbms_output.put(v_arr(i) || v_arr(j) || ' ');
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- 4. a, b, c, d, e 5개의 문자 중에서
-- (1) 중복을 허락해서 3개의 문자를 순서대로 나열해서 출력
--    (결과) aaa, aab, aac, aad, aae, aba, abb, abc, abd, ...
declare
    type arr is varray(5) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c', 'd', 'e');
    
    for i in 1..v_arr.count loop
        for j in 1..v_arr.count loop
            for k in 1..v_arr.count loop
                dbms_output.put(v_arr(i) || v_arr(j) || v_arr(k) ||' ');
            end loop;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/
-- (2) 중복을 허락하지 않고 3개의 문자를 순서대로 나열해서 출력
--    (결과) abc, abd, abe, acb, acd, ace, ... 
declare
    type arr is varray(5) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c', 'd', 'e');
    for i in 1..v_arr.count loop
        for j in i+1..v_arr.count loop
            for k in j+1..v_arr.count loop
                dbms_output.put(v_arr(i) || v_arr(j) || v_arr(k) || ' ');
            end loop;
        end loop;
        for j in REVERSE i+1..v_arr.count loop
            for k in REVERSE j+1..v_arr.count loop
                dbms_output.put(v_arr(k) || v_arr(j) || v_arr(i) || ' ');
            end loop;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/

-- (3) 중복을 허락하지 않고 3개의 문자를 선택해서 출력(순서는 중요하지 않음)
--    (결과) abc, abd, abe, bcd, bce, cde
declare
    type arr is varray(5) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c', 'd', 'e');
    for i in 1..v_arr.count loop
        for j in i+1..v_arr.count loop
            for k in i+2..v_arr.count loop
                exit when j=k;
                dbms_output.put(v_arr(i) || v_arr(j) || v_arr(k) || ' ');
            end loop;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/
-- (4) 3개의 문자(중복 가능)를 출력(순서는 중요하지 않음)
--    (결과) aaa, aab, aac, aad, abb, abc, ...
declare
    type arr is varray(5) of varchar2(20);
    v_arr arr;
begin
    v_arr := arr('a', 'b', 'c', 'd', 'e');
    
    for i in 1..v_arr.count loop
        for j in i..v_arr.count loop
            for k in j..v_arr.count loop
                dbms_output.put(v_arr(i) || v_arr(j) || v_arr(k) || ' ');
            end loop;
        end loop;
    end loop;
    dbms_output.new_line;
end;
/