-- Example of Common Table Expression used to find out how many of the top 5 customers are based within each country.

WITH top_5_per_country_cte(country)AS
(SELECT d.country,
 COUNT(DISTINCT a.customer_id) AS all_customer_count,
 COUNT(DISTINCT top_5_customers) AS top_customer_count

FROM
customer a
 INNER JOIN address b ON a.address_id = b.address_id
 INNER JOIN city c ON b.city_id = c.city_id
 INNER JOIN country d ON c.country_id = d.country_id

LEFT JOIN
(SELECT B.customer_id,
 B.first_name,
 B.last_name,
 E.country,
 D.city,
 SUM(A.amount) AS total_amount_paid

FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
INNER JOIN address C ON B.address_id = C.address_id
INNER JOIN city D ON C.city_id = D.city_id
INNER JOIN country E ON D.country_id = E.country_id 

WHERE D.city IN(
 SELECT D.city
 FROM payment A
 INNER JOIN customer B ON A.customer_id = B.customer_id
 INNER JOIN address C ON B.address_id = C.address_id
 INNER JOIN city D ON C.city_id = D.city_id
 INNER JOIN country E ON D.country_id = E.country_id
 
WHERE E.country IN (
 SELECT E.country
FROM payment A
INNER JOIN customer B ON A.customer_id = B.customer_id
 INNER JOIN address C ON B.address_id = C.address_id
 INNER JOIN city D ON C.city_id = D.city_id
 INNER JOIN country E ON D.country_id = E.country_id

GROUP BY E.country
ORDER BY COUNT (B.customer_id) DESC
LIMIT 10)
GROUP BY E.country, D.city
 ORDER BY COUNT(B.customer_id) DESC
 LIMIT 10)

GROUP BY B.customer_id,
 B.first_name,
B.last_name,
E.country,
D.city
ORDER BY total_amount_paid DESC
LIMIT 5) AS top_5_customers
ON a.customer_id = top_5_customers.customer_id
GROUP BY d.country
ORDER BY top_customer_count DESC)

SELECT * FROM top_5_per_country_cte










