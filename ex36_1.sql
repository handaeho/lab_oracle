/*
Procedure vs Function
1) Procedure
= Ư�� ������ �����ϱ⸸ �ϰ�, ��������� �������� �ʴ� ���� ���α׷�.
* ���� -> �ٸ� PL/SQL(���α׷�) ���ο��� �����. ��, SQL �������� ���� �Ұ�.
* �Ķ���� -> in, out, in out mode ��� ����.
* ��ȯ -> ���Ϲ��� ����� ��ȯ X. out / inout �Ķ���ͷ� 1�� �̻��� ���� ������ ����.

2) Function
= Ư�� ����� ������ ��, �ݵ�� ������� �����ϴ� ���� ���α׷�. 
* ���� -> �ٸ� PL/SQL(���α׷�) ���� �Ǵ� SQL ���� �ȿ��� ���� ����.
* �Ķ���� -> in mode�� ���. defualt�̹Ƿ� ���� ����.
                out, in out mode�� ���� �Լ��� SQL������ ��� �Ұ�. 
* ��ȯ -> �ݵ�� return���� ����� �� ���� �� ��ȯ �ʿ�.   

## Function ���� ##
create [or replace] function �Լ��̸� [(
    �Ķ����1 Ÿ�� [:= �⺻ ��],
    �Ķ����2 Ÿ�� [:= �⺻ ��],
    �Ķ����3 Ÿ�� [:= �⺻ ��]
    ... )]
return ����Ÿ��
is
begin
[exception]
end;
/

### Parameter vs Argument ###
1) Parameter (�Ű�����, ����)
= �Լ��� ���ν����� ������ ��, ���� �޴� ���� �����ϴ� ����.

2) Argument (�μ�, ��������)
= �Լ��� ���ν����� ȣ���� ��, �����ϴ� ��.
*/
--------------------------------------------------------------------------------------------------------------
set SERVEROUTPUT on;
--------------------------------------------------------------------------------------------------------------
create or replace function my_add(
    p_x number,
    p_y number)
return number
is
    v_result number; -- return�� ���� ����
begin
    v_result := p_x + p_y;
    return v_result; -- �Լ��� ȣ���� ������ ���� return.
end;
/

-- ����Ŭ �����Լ��� ����� Ȯ�ν�, dual ���� ���̺� ���.
-- �ۼ��� �Լ� ���� SQL ������ ��� Ȯ�� ����.
select my_add(1,2) from dual;

-- �Լ��� PL/SQL������ ��� ����.
declare
    v_result number;
begin
    v_result := my_add(100,200);
    dbms_output.put_line(v_result);
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace function my_sub(
    p_x number,
    p_y number)
return number
is
    v_result number;
begin
    v_result := p_x - p_y;
    return v_result;
end;
/

declare
    v_result number;
begin
    v_result := my_sub(200, 100);
    dbms_output.put_line(v_result);
end;
/
--------------------------------------------------------------------------------------------------------------
create or replace function my_str(
    p_x varchar,
    p_y varchar)
return varchar
is
    v_result varchar(20);
begin
    v_result := concat(p_x, p_y);
    return v_result;
end;
/

declare
    v_result varchar(20);
begin
    v_result := my_str('hello', 'world');
    dbms_output.put_line(v_result);
end;
/
--------------------------------------------------------------------------------------------------------------
-- ����� ������ �Ķ���ͷ� ���޹޾� ��ü �޿��� ���ض�
create or replace function my_sal(
    p_empno number,
    p_tax number)
return number
is
    v_totsal number;
    p_sal emp.sal%type;
    p_comm emp.comm%type;
    
begin
    select sal, nvl(comm,0) into p_sal, p_comm from emp where empno = p_empno;
    v_totsal := (p_sal + p_comm) * (1 - p_tax);
    return v_totsal;
    
--    select (sal + nvl(comm,0)) * (1 - p_tax) into v_totsal from emp where empno = p_empno;
--    return v_totsal;
end;
/

declare
    v_totsal number;
begin
    v_totsal := my_sal(7788, 0.05);
    dbms_output.put_line(v_totsal);
end;
/
--------------------------------------------------------------------------------------------------------------
-- ���丮�� �����
create or replace function my_fact(
    p_x number)
return number
is
    v_fact number := 1;    
begin
    for i in 1..p_x loop 
        v_fact := v_fact * i; 
    end loop;
   
    return v_fact;
end;
/

declare
    v_fact number;
begin
    v_fact := my_fact(10);
    dbms_output.put_line(v_fact);
end;
/
--------------OR---------------
create or replace function my_fact2(
    p_n number)
return number
is
    v_result number := -1; -- ��� ��� ����
begin
    if p_n =0 then
        v_result := 1;
        
        elsif p_n > 0 then
            v_result := my_fact2(p_n-1) * p_n;
    end if;
    return v_result;
end;
/

declare
    v_fact2 number;
begin
    v_fact2 := my_fact2(5);
    dbms_output.put_line(v_fact2);
end;
/
--------------------------------------------------------------------------------------------------------------
