set serveroutput on;

-- 1. 
-- ������(2�� ~ 9��)�� ���
declare
    v_dan number := 2;
    v_x number := 1;
begin
    loop
        v_x := 1;
        loop
            dbms_output.put_line(v_dan || ' x ' || v_x || ' = ' || (v_dan * v_x));
            v_x := v_x + 1;
            exit when v_x = 10;
        end loop;
        
        dbms_output.put_line('---------------');
        v_dan := v_dan + 1;
        exit when v_dan = 10;
    end loop;
end;
/


declare
    dan number;
    n   number;
begin
    dan := 2;  -- ������ 2�ܺ��� ����
    while dan < 10 loop
        dbms_output.put_line(dan || '��');
        
        -- �ش� ��(2��, 3��, ..., 9��) ���
        n := 1;
        while n < 10 loop
            dbms_output.put_line(dan || ' x ' || n || ' = ' || (dan * n));
            n := n + 1;
        end loop;
        
        dbms_output.put_line('---------------');
        dan := dan + 1;   
    end loop;
end;
/

begin

end;
/


-- 2. 
-- ������(2�� ~ 9��)�� ���.
-- 2���� 2x2����, 3���� 3x3����, 4���� 4x4����, ...

-- dbms_random.value(x, y) �Լ��� x���� ũ�ų� ����, y���� ���� ����(������ ����)�� �����մϴ�.
select dbms_random.value(0, 1) from dual;

-- 3. �������� ���� �������� �ո�� �޸��� ���� Ȯ���� 1/2���� �����ϼ���.
-- (1) dbms_random.value(x, y) �Լ��� ����ؼ� 0 �Ǵ� 1�� �������� ����ϴ� PL/SQL�� �ۼ��ϼ���.
-- (2) (1)���� �ۼ��� �ڵ带 �����ؼ�, 
-- ������ 0�̸� '���� �ո�(head)', 1�̸� '���� �޸�(tail)'�̶�� ����ϴ� PL/SQL�� �ۼ��ϼ���.
-- (3) 0 �Ǵ� 1�� �����ϰ� ����� ����((1) �ڵ�)�� 1000�� �ݺ��ؼ�, 0�� 1�� �߻� Ƚ���� �����ϰ�,
-- 0�� ���� Ƚ�� / ��ü Ƚ��, 1�� ���� Ƚ�� / ��ü Ƚ�� �� ���

-- 6. ����ī���� �˰����� �̿��� pi�� �ٻ簪(3.141592...) ���
-- (1) dbms_random.value() �Լ��� ����ؼ�, 2���� ��ǥ���(x-y) ���� ���� ��ǥ (x, y)�� �������� ����.
-- ��, 0 <= x < 1, 0 <= y < 1
-- (2) sqrt(x ** 2 + y ** 2 < 1)�� �����ϸ� v_hit ������ ���� 1 ����
-- (3) (1), (2)�� ������ 1000�� �ݺ�
-- (3) (v_hit / 1000) * 4�� ����� ���� ���
