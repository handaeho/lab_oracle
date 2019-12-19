set SERVEROUTPUT on;

-- 1. dbms_random.value() �Լ� �̿��ؼ�, �ֻ��� 2���� ������ �� ������ ���� (x, y) �������� ����ϴ� 
-- PL/SQL�� �ۼ��ϼ���. �ֻ��� 2���� ���� �������� �� ����� ���߼���.
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

-- 2.�Ǻ���ġ ������ ���� 20���� ����ϴ� PL/SQL�� �ۼ��ϼ���.
-- �̿��ϴ� �Ǻ���ġ ���� ������ Ȳ�ݺ�(golden ratio)�� �Ҹ��� �� 1.61803...�� �������� ���̼���.
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
        dbms_output.put_line('Ȳ�ݺ��� : '|| f1 /f2);
    end loop;

end;
/

-- 3. ����(Permutation), ����(Combination)
-- a, b, c 3���� ���� �߿���

-- (1) �ߺ��� ����ؼ� 2���� ���ڸ� ������� �����ؼ� ���
--    (���) aa, ab, ac, ba, bb, bc, ca, cb, cc
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

-- (2) �ߺ��� ������� �ʰ� 2���� ���ڸ� ������� �����ؼ� ���
--    (���) ab, ac, ba, bc, ca, cb 
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

-- (3) �ߺ��� ������� �ʰ� 2���� ���ڸ� �����ؼ� ���(������ �߿����� ����)
--    (���) ab, ac, bc
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

-- (4) 2���� ����(�ߺ� ����)�� ���(������ �߿����� ����)
--    (���) aa, ab, ac, bb, bc, cc
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

-- 4. a, b, c, d, e 5���� ���� �߿���
-- (1) �ߺ��� ����ؼ� 3���� ���ڸ� ������� �����ؼ� ���
--    (���) aaa, aab, aac, aad, aae, aba, abb, abc, abd, ...
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
-- (2) �ߺ��� ������� �ʰ� 3���� ���ڸ� ������� �����ؼ� ���
--    (���) abc, abd, abe, acb, acd, ace, ... 
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

-- (3) �ߺ��� ������� �ʰ� 3���� ���ڸ� �����ؼ� ���(������ �߿����� ����)
--    (���) abc, abd, abe, bcd, bce, cde
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
-- (4) 3���� ����(�ߺ� ����)�� ���(������ �߿����� ����)
--    (���) aaa, aab, aac, aad, abb, abc, ...
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