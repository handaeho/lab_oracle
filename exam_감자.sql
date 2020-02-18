--21. 제품 카테고리별, 연도별로 구매횟수, 누적 구매횟수, 매출액(amount_sold), 누적 매출액을 구하는 SQL 문장을 작성하시오.

--22. 제품 카테고리 중에서 '하드웨어'를 25번 이상 구매하였거나, 총 $40,000 이상 구입했던 고객들의 
-- 국가, 도시, Last name, Age, Income level, 구매횟수, 매출액(amount_sold) 등을 내림차순으로 구하는 SQL 문장을 작성하시오.
SELECT country_name as 국가, cu.cust_city as 도시, cu.cust_last_name as 성, 
            EXTRACT(year from sysdate) - cu.cust_year_of_birth as 나이,
            cu.cust_income_level as 수입레벨,
            구매횟수, 매출액
FROM ( SELECT cust_id, count(s.prod_id) as 구매횟수, sum(s.amount_sold) as 매출액
            FROM sales s, products p
            WHERE s.prod_id = p.prod_id and p.prod_category_id = 202
            GROUP BY s.cust_id
            HAVING count(s.prod_id) >= 25 or sum(s.amount_sold) >= 40000
            ORDER BY sum(s.amount_sold) desc) A,
            countries co, customers cu
WHERE cu.cust_id = A.cust_id and co.country_id = cu.country_id
ORDER BY 매출액 desc;

--23. 국가별로 제품 구매 횟수, 구매 고객수, 평균 구매 횟수, 등록 고객수, 
-- 구매 고객 비율(구매 고객수/등록 고객수) 등을 구하는 SQL 문장을 작성하시오.

--24. 가장 많은 매출을 올려준 고객 3명의 ID와 매출액을 검색하는 SQL은?
SELECT *
FROM ( SELECT CUST_ID , sum(amount_sold) as amount_sold
            FROM sales
            GROUP BY cust_id
            ORDER BY amount_sold desc)
WHERE ROWNUM < 4;
    
--25. 처음 매출은 언제이고 최근 매출은 언제인가?
SELECT A.time_id as 처음, B.time_id as 최근
FROM (SELECT time_id 
            FROM sales
            ORDER BY time_id) A,
            (SELECT time_id
            FROM sales
            ORDER BY time_id desc) B
WHERE ROWNUM < 2;

--26. 가장 빈번하게 상품을 구매한 고객 3명의 ID는 무엇인가?
SELECT *
FROM (SELECT cust_id, sum(quantity_sold) as quan, sum(amount_sold) as sold
            FROM sales
            GROUP BY cust_id
            ORDER BY quan desc)
WHERE ROWNUM < 4;

--27. 어떤 promotion에 고객이 제일 많이 상품을 구매했는가?
SELECT A.promo_id, A.quan, promo_name
FROM ( SELECT promo_id, sum(quantity_sold) as quan
            FROM sales
            GROUP BY promo_id
            ORDER BY quan desc) A,
            promotions
WHERE ROWNUM < 2 and A.promo_id = promotions.promo_id;

--28. 고객이 가장 많이 이용한 channel 은 무엇인가?
SELECT A.channel_id, A.freq, channels.channel_desc
FROM ( SELECT channel_id, count(distinct cust_id) as freq 
            FROM sales
            GROUP BY channel_id) A, 
            channels
WHERE ROWNUM<2 and A.channel_id = channels.channel_id;



