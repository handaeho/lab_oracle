-- ���ڿ� �Լ�
-- upper('Sql Course');
-- �Լ� ȣ���� ����� ����ϱ� ���� ���� ���̺�: dual
select upper('Sql Course') from dual;
select lower('Sql Course') from dual;
select initcap('sql course') from dual;

select ename, upper(ename), lower(ename), initcap(ename)
from emp;

select * from emp
where upper(ename) = upper('scott');

-- ���� �̸� �߿� 'la'�� ���Ե� ��� �������� ���� ���
select * from emp
where lower(ename) like lower('%la%');

select concat('Hello', 'World') from dual;

-- substr(���ڿ�, �����ε���, ���ڰ���)
-- ����° argument�� �߶� ���� ������ �������� �ʴ� ��쿡��
-- ���ڿ����� �����ε������� �� ���ڿ��� ������ �߶�
-- Hello
-- 12345
select substr('HelloWorld', 1, 5) from dual;
select substr('HelloWorld', 1, 4) from dual;
select substr('HelloWorld', 2, 4) from dual;
select substr('HelloWorld', 2) from dual;
select substr('http://www.google.com', 8) from dual;

-- length(���ڿ�): ���ڼ�(������ ����)�� ���� 
select length('Hello'), lengthb('Hello') from dual;
select length('�ѱ�'), lengthb('�ѱ�') from dual;

-- emp ���̺��� ���� �̸��� 6���� �̻��� �������� ���ڵ带 ���
select ename from emp where length(ename) > 5;

select instr('HelloWorld', 'W') from dual;
select instr('HelloWorld', 'w') from dual;
select instr(lower('HelloWorld'), 'w') from dual;
select instr('HelloWorld', 'l') from dual;
select instr('HelloWorld', 'l', 5) from dual;

select lpad('hello', 10, '*') from dual;
select rpad('hello', 10) from dual;
select rpad(substr('hello', 1, 1), length('hello'), '*') from dual;
select rpad('h', 5, '*') from dual;

select replace('jack and jue', 'j', 'bl') from dual;

select trim('h' from 'hhello hello ollehhhh') from dual;
select trim(' ' from '     hello     hello     olleh     ') from dual;

-- ���� ���� �Լ�
-- round():  �ݿø� 
select round(1234.5678, 0), round(1234.5678, 1), round(1234.5678, 2),
       round(1234.5678, -1), round(1234.5678, -2)
from dual;

-- trunc(): ����
select trunc(1234.5678, 0), trunc(1234.5678, 1), trunc(1234.5678, 2),
       trunc(1234.5678, -1), trunc(1234.5678, -2)
from dual;

-- mod(): ���� �������� ��� 
select mod(7, 3) from dual;
select trunc(7 / 3, 0), mod(7, 3) from dual;

select ceil(3.14), floor(3.14) from dual;
select ceil(-3.14), floor(-3.14) from dual;

-- ��¥ ���� �Լ�
select sysdate from dual;
select add_months(sysdate, 1) from dual;

select sysdate + 2 from dual;
select add_months(sysdate + 2, 1) from dual;

select months_between(sysdate, hiredate) from emp;
select months_between(hiredate, sysdate) from emp;

select round(sysdate, 'YYYY'), round(sysdate, 'Q')
from dual;

select trunc(sysdate, 'YYYY'), trunc(sysdate, 'Q')
from dual;


-- ������ Ÿ�� ��ȯ �Լ�
-- to_char(): ���ڿ��� ����
-- to_number(): ���ڸ� ����
-- to_date(): ��¥�� ����

-- ����Ŭ���� ��Ģ������(+, -, *, /)�� ���� Ÿ�Կ����� ��� ����
-- (date Ÿ���� +, -�� ����)
select '1000' + '100' from dual;
-- ����Ŭ�� ���ڷ� ��ȯ�� �� �ִ� ���ڿ����� ��쿡��
-- ���������� Ÿ�� ��ȯ�� ������ �� ��Ģ ���� ����� ��
select '1000' + 'abc' from dual;
-- ���ڷ� ��ȯ�� �� ���� ���ڿ��� ��� ��Ģ ������ �ϸ� invalid number ������ �߻���

select '1,000' + '100' from dual; -- invalid number
select to_number('12,000', '999,999') + to_number('100', '999') 
from dual;


-- ��¥(date) Ÿ���� ���� SQL Developer�� ȯ�漳������ ������ �������� ��µ�
-- ���� -> ȯ�漳�� -> �����ͺ��̽� -> NLS(National Language Support)
-- ��¥ �����͸� ���ϴ� �������� ����ϰ� ���� �� to_char(��¥, ����) �Լ��� ���
select sysdate, 
       to_char(sysdate, 'YY-MM-DD'),
       to_char(sysdate, 'AM HH:MI:SS'),
       to_char(sysdate, 'DY'),
       to_char(sysdate, 'DAY')
from dual;

-- to_date(���ڿ�, ��¥����)
select to_date('2019/08/29'), to_date('19/08/29') from  dual;
select to_date('2019/08/29', 'YYYY/MM/DD'), 
       to_date('99/08/29', 'YY/MM/DD'),
       to_date('99/08/29', 'RR/MM/DD') 
from  dual;

select comm, nvl(comm,0), nvl2(comm,'o','x') from emp;



