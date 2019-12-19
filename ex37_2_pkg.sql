-- ��Ű�� �� �ۼ�

create or replace package my_stat
is
-- ���� Ÿ���� �����ϰ� ���� ������ �ε����� ���� ���̺�
    type NumberArray is table of number index by PLS_INTEGER;
    arr NumberArray;
    
-- �Լ� �̸� sum = �Ķ���Ϳ� ���޹��� �迭�� ��� ���� ���� ����.
    function v_sum(arr NumberArray) return number;
    
-- �Լ� �̸� avg = �Ķ���Ϳ� ���޹��� �迭�� ��� ���� ����� ����. 
-- digit = ���ϰ�(��հ�)�� �Ҽ��� ���� �ڸ���. �⺻���� 3. (ex) digit = 1 -> �Ҽ��� 1�ڸ����� ���)
    function v_avg(arr NumberArray, digit number := 3) return number;
    
-- �Լ� �̸� var = �Ķ���Ϳ� ���޹��� �迭�� ��� ���� �л��� ����.
    function v_var(arr NumberArray, digit number := 3) return number;
    
-- �Լ� �̸� std = �Ķ���Ϳ� ���޹��� �迭�� ��� ���� ǥ�������� ����.
    function v_std(arr NumberArray, digit number := 3) return number;
    
-- �Լ� �̸� max = �Ķ���Ϳ� ���޹��� �迭�� ��� ���� �ִ밪�� ����.
    function v_max(arr NumberArray) return number;
    
-- �Լ� �̸� min = �Ķ���Ϳ� ���޹��� �迭�� ��� ���� �ּҰ��� ����.
    function v_min(arr NumberArray) return number;

end;
/

-- ��Ű�� ���� �ۼ�

create or replace package body my_stat
is
-- ��Ű�� ���� ����� �Լ� ����.   

-- �հ�
    function v_sum(arr NumberArray)
    return number
    is
        p_sum number := 0;
    begin
        for i in 1..arr.count loop
            p_sum := p_sum + arr(i); 
        end loop;
        
        return p_sum;
        
        DBMS_OUTPUT.PUT_LINE(p_sum);
    end v_sum;
    
-- ���
    function v_avg(arr NumberArray, digit number)
        return number
        is
            p_avg number := 0;
 
        begin
            p_avg := trunc((my_stat.v_sum(arr) / arr.count), digit); 
            
            return p_avg;
            DBMS_OUTPUT.PUT_LINE(p_avg);
        end v_avg;
        
-- �л�        
    function v_var(arr NumberArray, digit number)
        return number
        is
            p_var number := 0;
            pp_var number;
            
        begin            
            for i in 1..arr.count loop
                p_var := p_var + power((arr(i) - my_stat.v_avg(arr,digit)),2);
            end loop;
            
            pp_var := trunc((p_var / arr.count - 1),digit);
            
            return pp_var;
            
            DBMS_OUTPUT.PUT_LINE(pp_var);
        end v_var;
        
-- ǥ������        
        function v_std(arr NumberArray, digit number)
        return number
        is
            p_std number;            
        begin           
            p_std := trunc(sqrt(my_stat.v_var(arr,digit)), digit);
            
            return p_std;
            
            DBMS_OUTPUT.PUT_LINE(p_std);
        end v_std;
        
-- �ִ밪        
        function v_max(arr NumberArray)
        return number
        is
--            v_arr numberArray := arr;
--            p_max number;
--            temp number;
--            mini number;
--            indx number;
            v_result number; -- �ִ밪 ����
        begin
--            for i in 1..(arr.count - 1) loop
--                mini := v_arr(i);
--                indx := i;
--                for j in i+1..arr.count loop
--                    if mini > v_arr(j) then
--                        mini := v_arr(j);
--                        indx := j;
--                    end if;
--                end loop;
--                if indx != i then
--                    temp := v_arr(i);
--                    v_arr(i) := v_arr(indx);
--                    v_arr(indx) := temp;
--                end if;
--            end loop;
--
--            p_max := v_arr.last;
            
            v_result := arr(1);
            
            for i in 2..arr.count loop
                if arr(i) > v_result then
                    v_result := arr(i);
                end if;
            end loop;
            
            return v_result;

            DBMS_OUTPUT.PUT_LINE(v_result);
        end v_max;
        
-- �ּҰ�        
        function v_min(arr NumberArray)
        return number
        is
            v_result number; -- �ּҰ� ����
        begin
            v_result := arr(1);
            
            for i in 2..arr.count loop
                if arr(i) < v_result then
                    v_result := arr(i);
                end if;
            end loop;
            
            return v_result;

            DBMS_OUTPUT.PUT_LINE(v_result);
        end v_min;
end;
/

