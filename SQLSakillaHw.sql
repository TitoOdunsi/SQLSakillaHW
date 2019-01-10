USE sakila;
select first_name, last_name
FROM actor;

SELECT CONCAT (first_name, " ", last_name) AS "Actor Name"
FROM actor;
SELECT actor_id, first_name, last_name
FROM actor;

SELECT actor_id, first_name, last_name
FROM actor 
WHERE last_name LIKE '%GEN%';

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');


ALTER TABLE actor
ADD description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(last_name) as 'Number of Actors'
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) as 'Number of Actors'
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

DESCRIBE sakila.address;


SELECT staff.first_name, staff.last_name, address.address
FROM staff LEFT JOIN address
USING (address_id);

SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total'
FROM staff LEFT JOIN payment
USING (staff_id)
WHERE payment.payment_date LIKE '2005-08-%'
GROUP BY staff.first_name, staff.last_name;

SELECT film.title, COUNT(film_actor.actor_id) AS 'Number_Actors'
FROM film INNER JOIN film_actor
USING (film_id)
GROUP BY film_id;

SELECT film.title, COUNT(inventory.film_id) AS 'Number'
FROM film INNER JOIN inventory
USING (film_id)
WHERE film.title = 'HUNCHBACK IMPOSSIBLE'
GROUP BY film_id;

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS 'Total Amount Paid'
FROM customer LEFT JOIN payment
USING (customer_id)
GROUP BY customer_id
ORDER BY customer.last_name;

SELECT title 
FROM film
WHERE language_id =(SELECT language_id FROM language WHERE name = 'English')
AND (title LIKE 'K%' OR title LIKE 'Q%');

SELECT first_name, last_name 
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title = 'ALONE TRIP'));

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id FROM address WHERE city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country WHERE country = 'Canada')));

SELECT title
FROM film 
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id IN (SELECT category_id FROM category WHERE name = 'Family'));

SELECT title, COUNT(film.film_id) as 'total'
FROM film
JOIN inventory ON (film.film_id = inventory.film_id)
JOIN rental ON (rental.inventory_id = inventory.inventory_id)
GROUP BY title
ORDER BY total DESC;

SELECT store.store_id, SUM(payment.amount) AS 'total'
FROM store
JOIN staff ON (store.store_id = staff.store_id)
JOIN payment ON (staff.staff_id = payment.staff_id)
GROUP BY store_id;

SELECT store.store_id, country.country, city.city
FROM store
JOIN address ON (store.address_id = address.address_id)
JOIN city ON (address.city_id = city.city_id)
JOIN country ON (city.country_id = country.country_id)
GROUP BY store_id;

SELECT category.name, SUM(payment.amount) AS 'total'
FROM category
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY name
ORDER BY total DESC
LIMIT 5;

CREATE VIEW TopFive AS
SELECT category.name AS "Top Five", SUM(payment.amount) AS "Gross"
FROM category
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY name
ORDER BY Gross DESC
LIMIT 5;

SELECT * FROM TopFive;
DROP VIEW TopFive;