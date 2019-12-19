/*
Procedure(���ν���) vs Function(�Լ�)
1. Procedure(���ν���)
  (1) Ư���� ������ �����ϱ⸸ �ϰ�, ��������� ��ȯ(return)���� �ʴ� ���� ���α׷�
  (2) ����: �ٸ� PL/SQL (���α׷�) ���ο��� �����. SQL �������� ����� �� ����.
  (3) �Ķ����: in, out, in out ������ ����� �� ����.
  (4) ��ȯ: return ���� ����� ��ȯ�� �� �� ����.
  out/in out �Ķ���͸� ���ؼ� 1�� �̻��� ���� ��ȯ�� ���� ����.
  
2. Function(�Լ�)
  (1) Ư���� ����� ������ �� �ݵ�� ������� ��ȯ(return)�ϴ� ���� ���α׷�
  (2) ����: �ٸ� PL/SQL (���α׷�) ���� �Ǵ� SQL ���� �ȿ��� ����� �� ����.
  (3) �Ķ����: in ����� �Ķ���͸� ���. in�� ����.
  ���������δ� �Լ������� out, in out �Ķ���͸� ����� �� ������,
  out/in out �Ķ���͸� ���� �Լ��� SQL ���忡�� ����� �� ����!
  ����Ŭ������ out/in out �Ķ���͸� �Լ����� ������� ����� ������.
  (4) ��ȯ: �ݵ�� return ���� ����ؼ� 1���� ���� ��ȯ�ؾ� ��!

�Լ��� �����ϴ� ���:
create [or replace] function �Լ��̸� [(
    �Ķ����1 Ÿ�� [:= �⺻��1],
    �Ķ����2 Ÿ�� [:= �⺻��2],
    ...
)]
return ����Ÿ��
is
begin
[exception -- ���� ó����]
end;
*/

create or replace function my_add(
    p_x number,
    p_y number
) return number
is
--    v_result number;  -- ���ϰ��� �����ϱ� ���� ����
begin
--    v_result := p_x + p_y;
--    return v_result; -- �Լ��� ȣ���� ������ ���� ��ȯ(return)
    return p_x + p_y;
end;
/

-- ����Ŭ ���� �Լ��� ������� Ȯ���� �� dual ���� ���̺� ���.
select upper('itwill') from dual;

-- �츮�� �ۼ��ϴ� �Լ��� SQL������ �����(return value)�� Ȯ���� �� ����.
select my_add(1, 2) from dual;

-- �Լ��� PL/SQL������ ��� ����
set serveroutput on;
declare
    v_result number;
begin
    v_result := my_add(100, 200);
    dbms_output.put_line(v_result);
end;
/


-- ���� �ΰ��� �Ķ���ͷ� ���޹޾Ƽ� ������ ����� �����ϴ� �Լ��� �ۼ�/�׽�Ʈ
create or replace function func_sub(
    p_x number,
    p_y number
) return number
is
begin
    return p_x - p_y;
end;
/

select func_sub(1, 2), func_sub(2, 1) from dual;

declare
    v_result number;
begin
    v_result := func_sub(123, 100);
    dbms_output.put_line(v_result);
end;
/


-- ���ڿ� �ΰ��� �Ķ���ͷ� ���޹޾Ƽ� 
-- �� ���ڿ��� �ϳ��� ��ģ ���ڿ��� �����ϴ� �Լ��� �ۼ�/�׽�Ʈ
-- 'Hello', 'World' -> 'HelloWorld'
create or replace function my_concat(
    str1 varchar2,
    str2 varchar2
) return varchar2
is
--    v_result varchar2(32767);
begin
--    v_result := str1 || str2;
--    return v_result;
    return str1 || str2;
end;
/

select my_concat('Hello', 'World') from dual;

declare
    v_result varchar2(100);
begin
    select my_concat(ename, job) into v_result
    from emp
    where empno = 7788;
    dbms_output.put_line(v_result);
end;
/


-- ����� ������ �Ķ���ͷ� ���޹޾Ƽ�
-- �ش� ����� �� �޿�( (sal + comm) * (1 - tax) )�� ����ؼ� �����ϴ� �Լ�
create or replace function func_total_sal(
    p_empno number,
    p_tax number := 0.05
) return number
is
    v_total number;  -- �� �޿��� ����� ����� ������ ����
begin
    select (sal + nvl(comm, 0)) * (1 - p_tax)
    into v_total
    from emp
    where empno = p_empno;
    
    return v_total;
end;
/


select empno, ename, sal, comm, func_total_sal(7788)
from emp
where empno = 7788;

declare
    cursor cur_empno is
        select empno from emp;
    type rec_emp_sal is record (
        empno   emp.empno%type,
        ename   emp.ename%type,
        sal     emp.sal%type,
        comm    emp.comm%type,
        total   number
    );
    v_result rec_emp_sal;
begin
    for r in cur_empno loop
        select empno, ename, sal, comm, func_total_sal(r.empno)
        into v_result
        from emp
        where empno = r.empno;
        
        dbms_output.put_line(v_result.empno || ' : ' 
                        || v_result.ename || ' : '
                        || v_result.sal || ' : '
                        || v_result.comm || ' : '
                        || v_result.total);
    end loop;
end;
/


-- factorial ��� ����� �����ϴ� �Լ�
-- 0! = 1
-- 1! = 1 x 1 = 1
-- 2! = 1 x 2 = 2
-- 3! = 1 x 2 x 3 = 6

create or replace function my_factorial(n number) return number
is
    v_result number := 1;  -- ��� ����� ������ ����
begin
    for i in 1..n loop
        v_result := v_result * i;
    end loop;

    return v_result;
end;
/

begin
    for n in 0..5 loop
        dbms_output.put_line(my_factorial(n));
    end loop;
end;
/

create or replace function factorial2(n number) return number
is
    v_result number := -1; -- ��� ����� ������ ����
begin
    if n = 0 then
        v_result := 1;
    elsif n > 0 then
        v_result := factorial2(n - 1) * n;
        -- ��� ȣ��(recursion): �Լ� ���ο��� �ڱ� �ڽ��� �ٽ� ȣ���ϴ� ��
    end if;
    
    return v_result;
end;
/

begin
    for n in 0..5 loop
        dbms_output.put_line(factorial2(n));
    end loop;
end;
/

/*
Parameter(�Ű�����, ����) vs Argument(�μ�, ��������)
- parameter: �Լ�, ���ν����� ������ �� ���޹޴� ���� �����ϱ� ���ؼ� 
    �����ϴ� ����
    create procedure proc_name(param1 number, param2 varchar2, ...)
    create function func_name(param1 number, param2 varchar2, ...) return number
- argument: �Լ�, ���ν����� ȣ���� �� �����ϴ� ��
    proc_name(123, 'abc');
    func_name(100, '������');
*/








