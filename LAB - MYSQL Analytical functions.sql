SELECT 
    customer_id, 
    payment_date, 
    amount,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total
FROM payment
ORDER BY customer_id, payment_date;


SELECT 
    DATE(payment_date) AS payment_dt, 
    amount, 
    RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS dense_rnk
FROM payment;


SELECT 
    c.name AS category, 
    f.title AS film_title, 
    f.rental_rate,
    RANK() OVER (PARTITION BY fc.category_id ORDER BY f.rental_rate DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY fc.category_id ORDER BY f.rental_rate DESC) AS dens_rank
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;


SELECT 
    payment_id, 
    customer_id, 
    amount, 
    payment_date, 
    amount - LAG(amount, 1) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_from_prev,
    amount - LEAD(amount, 1) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_from_next
FROM payment;


