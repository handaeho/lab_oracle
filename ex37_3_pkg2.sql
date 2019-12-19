-- ex37_2_pkg에서 작성한 패키지 테스트.
declare
    v_score my_stat.NumberArray;
begin
    for i in 1..10 loop
        v_score(i) := trunc(dbms_random.value(0,11));
    end loop;
    
    for i in 1..10 loop
        dbms_output.put(v_score(i) || '  ');
    end loop;
    dbms_output.new_line;

    dbms_output.put_line('sum = ' || my_stat.v_sum(v_score));
    dbms_output.put_line('avg = ' || my_stat.v_avg(v_score,3));
    dbms_output.put_line('var = ' || my_stat.v_var(v_score,3));
    dbms_output.put_line('std = ' || my_stat.v_std(v_score,3));
    dbms_output.put_line('max = ' || my_stat.v_max(v_score));
    dbms_output.put_line('min = ' || my_stat.v_min(v_score));
end;
/