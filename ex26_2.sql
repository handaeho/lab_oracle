set serveroutput on;
ACCEPT x PROMPT '¸î´Ü?';

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