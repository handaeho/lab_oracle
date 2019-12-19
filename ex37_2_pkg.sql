-- 패키지 명세 작성

create or replace package my_stat
is
-- 숫자 타입을 저장하고 양의 정수를 인덱스로 갖는 테이블
    type NumberArray is table of number index by PLS_INTEGER;
    arr NumberArray;
    
-- 함수 이름 sum = 파라미터에 전달받은 배열의 모든 원소 합을 리턴.
    function v_sum(arr NumberArray) return number;
    
-- 함수 이름 avg = 파라미터에 전달받은 배열의 모든 원소 평균을 리턴. 
-- digit = 리턴값(평균값)의 소수점 이하 자릿수. 기본값은 3. (ex) digit = 1 -> 소수점 1자리까지 계산)
    function v_avg(arr NumberArray, digit number := 3) return number;
    
-- 함수 이름 var = 파라미터에 전달받은 배열의 모든 원소 분산을 리턴.
    function v_var(arr NumberArray, digit number := 3) return number;
    
-- 함수 이름 std = 파라미터에 전달받은 배열의 모든 원소 표준편차를 리턴.
    function v_std(arr NumberArray, digit number := 3) return number;
    
-- 함수 이름 max = 파라미터에 전달받은 배열의 모든 원소 최대값을 리턴.
    function v_max(arr NumberArray) return number;
    
-- 함수 이름 min = 파라미터에 전달받은 배열의 모든 원소 최소값을 리턴.
    function v_min(arr NumberArray) return number;

end;
/

-- 패키지 본문 작성

create or replace package body my_stat
is
-- 패키지 명세에 선언된 함수 구현.   

-- 합계
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
    
-- 평균
    function v_avg(arr NumberArray, digit number)
        return number
        is
            p_avg number := 0;
 
        begin
            p_avg := trunc((my_stat.v_sum(arr) / arr.count), digit); 
            
            return p_avg;
            DBMS_OUTPUT.PUT_LINE(p_avg);
        end v_avg;
        
-- 분산        
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
        
-- 표준편차        
        function v_std(arr NumberArray, digit number)
        return number
        is
            p_std number;            
        begin           
            p_std := trunc(sqrt(my_stat.v_var(arr,digit)), digit);
            
            return p_std;
            
            DBMS_OUTPUT.PUT_LINE(p_std);
        end v_std;
        
-- 최대값        
        function v_max(arr NumberArray)
        return number
        is
--            v_arr numberArray := arr;
--            p_max number;
--            temp number;
--            mini number;
--            indx number;
            v_result number; -- 최대값 저장
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
        
-- 최소값        
        function v_min(arr NumberArray)
        return number
        is
            v_result number; -- 최소값 저장
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

