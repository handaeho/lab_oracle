--21. ��ǰ ī�װ���, �������� ����Ƚ��, ���� ����Ƚ��, �����(amount_sold), ���� ������� ���ϴ� SQL ������ �ۼ��Ͻÿ�.

--22. ��ǰ ī�װ� �߿��� '�ϵ����'�� 25�� �̻� �����Ͽ��ų�, �� $40,000 �̻� �����ߴ� ������ 
-- ����, ����, Last name, Age, Income level, ����Ƚ��, �����(amount_sold) ���� ������������ ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT country_name as ����, cu.cust_city as ����, cu.cust_last_name as ��, 
            EXTRACT(year from sysdate) - cu.cust_year_of_birth as ����,
            cu.cust_income_level as ���Է���,
            ����Ƚ��, �����
FROM ( SELECT cust_id, count(s.prod_id) as ����Ƚ��, sum(s.amount_sold) as �����
            FROM sales s, products p
            WHERE s.prod_id = p.prod_id and p.prod_category_id = 202
            GROUP BY s.cust_id
            HAVING count(s.prod_id) >= 25 or sum(s.amount_sold) >= 40000
            ORDER BY sum(s.amount_sold) desc) A,
            countries co, customers cu
WHERE cu.cust_id = A.cust_id and co.country_id = cu.country_id
ORDER BY ����� desc;

--23. �������� ��ǰ ���� Ƚ��, ���� ����, ��� ���� Ƚ��, ��� ����, 
-- ���� �� ����(���� ����/��� ����) ���� ���ϴ� SQL ������ �ۼ��Ͻÿ�.

--24. ���� ���� ������ �÷��� �� 3���� ID�� ������� �˻��ϴ� SQL��?
SELECT *
FROM ( SELECT CUST_ID , sum(amount_sold) as amount_sold
            FROM sales
            GROUP BY cust_id
            ORDER BY amount_sold desc)
WHERE ROWNUM < 4;
    
--25. ó�� ������ �����̰� �ֱ� ������ �����ΰ�?
SELECT A.time_id as ó��, B.time_id as �ֱ�
FROM (SELECT time_id 
            FROM sales
            ORDER BY time_id) A,
            (SELECT time_id
            FROM sales
            ORDER BY time_id desc) B
WHERE ROWNUM < 2;

--26. ���� ����ϰ� ��ǰ�� ������ �� 3���� ID�� �����ΰ�?
SELECT *
FROM (SELECT cust_id, sum(quantity_sold) as quan, sum(amount_sold) as sold
            FROM sales
            GROUP BY cust_id
            ORDER BY quan desc)
WHERE ROWNUM < 4;

--27. � promotion�� ���� ���� ���� ��ǰ�� �����ߴ°�?
SELECT A.promo_id, A.quan, promo_name
FROM ( SELECT promo_id, sum(quantity_sold) as quan
            FROM sales
            GROUP BY promo_id
            ORDER BY quan desc) A,
            promotions
WHERE ROWNUM < 2 and A.promo_id = promotions.promo_id;

--28. ���� ���� ���� �̿��� channel �� �����ΰ�?
SELECT A.channel_id, A.freq, channels.channel_desc
FROM ( SELECT channel_id, count(distinct cust_id) as freq 
            FROM sales
            GROUP BY channel_id) A, 
            channels
WHERE ROWNUM<2 and A.channel_id = channels.channel_id;



