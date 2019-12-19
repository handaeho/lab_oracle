-- ���ǹ�, �ݺ��� ���� 

set serveroutput on;

begin
    dbms_output.put_line('hello');
    dbms_output.put_line('world');
    dbms_output.put('hello');
    dbms_output.put('world');
    dbms_output.new_line;
end;
/

-- ȭ�鿡 ***** ���
begin
    -- (1)
--    dbms_output.put_line('*****');
    
    -- (2)
--    dbms_output.put('*');
--    dbms_output.put('*');
--    dbms_output.put('*');
--    dbms_output.put('*');
--    dbms_output.put('*');
--    dbms_output.new_line;

    -- (3)
    for i in 1..5 loop
        dbms_output.put('*');
    end loop;
    dbms_output.new_line;
end;
/

/*
�Ʒ��� ���� ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*
**
***
****
*****

�Ʒ��� ���� ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*****
****
***
**
*

*/

begin
    for i in 1..5 loop
        for j in 1..i loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
        
    end loop;
end;
/

begin
    for i in 1..5 loop
        for j in i..5 loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
        
    end loop;
end;
/

declare
    i number;
    j number;
begin 
    i := 1;
    loop
        j := 1;
        loop
            dbms_output.put('*');
            j := j + 1;
            exit when j > i;
        end loop;
        dbms_output.new_line();
        
        i := i + 1;
        exit when i > 5;
    end loop;
end;
/


/*
�Ʒ��� ���� ����ϴ� PL/SQL
1 2 3 4 5 6 7 8 9 10
11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30
...
91 92 93 94 95 96 97 98 99 100
*/
begin
    for x in 1..100 loop
        -- dbms_output.put(x || ' ');
        dbms_output.put(rpad(x, 4, ' ');
        if mod(x, 10) = 0 then
            dbms_output.new_line();
        end if;
    end loop;
    
    dbms_output.new_line();
end;
/




/*
�Ʒ��� ���� ����ϴ� PL/SQL
1  2  *  4  5  *  7  8  *  10
11 12 *  14 15 *  17 18 *  20
21 22 *  24 25 *  27 28 *  *
*  *  #  *  *  #  *  *  #  40
...
*  *  #  *  *  #  *  *  #  100
*/

set serveroutput on;

ACCEPT p PROMPT '369 ����! 1000���� �Է� �ٶ��ϴ�.';

declare 
num number := &p; 
q number;
w number;
e number;

begin 
    dbms_output.new_line(); 
    for a in 1..num loop
     q := mod(a,10); -- 1�� �ڸ�
     w := mod(trunc(a/10,0),10); -- 10���ڸ�
     e := mod(trunc(a/100,0),10); -- 100�� �ڸ�
        if q in (3, 6, 9) and w in (3, 6, 9) and e in (3, 6, 9) then 
                dbms_output.put(' ¦¦¦ '); 
        elsif (q in (3, 6, 9) and w in (3, 6, 9)) or (q in (3, 6, 9) and e in (3, 6, 9)) or (w in (3, 6, 9) and e in (3, 6, 9)) then 
                dbms_output.put(' ¦¦ '); 
        elsif q in (3, 6, 9) or w in (3, 6, 9) or e in (3, 6, 9) then 
                dbms_output.put(' ¦ '); 
        else 
            dbms_output.put(' ' || a || ' '); 
        end if;  
        
        if mod(a, 10) = 0 then
            dbms_output.new_line();
        end if;
    end loop;
    dbms_output.new_line();   
end; 
/

-- ���丮��
set serveroutput on;

ACCEPT p PROMPT '���丮��~';
declare
    num number := &p;
    x number;
    result number := 1;
begin
    for x in 1..num loop
        result := result * x;
        dbms_output.put('x' || x);
    end loop;
    dbms_output.new_line(); 
    
    dbms_output.put(' result = ' || result); 
    dbms_output.new_line(); 
end;
/