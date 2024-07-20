# Example of a subquery used to find the average amount paid by the top 5 customers


SELECT B.customer_id, 
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
LIMIT 5;
