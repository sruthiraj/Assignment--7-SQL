USE sakila;

-- Question 1a --
SELECT  * FROM actor;
SELECT first_name, last_name FROM actor;

-- Question 1b --
SELECT concat(first_name, " ", last_name) AS 'Actor Name' 
FROM actor;

-- Question 2a --
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- Question 2b --
SELECT * FROM actor
WHERE last_name LIKE '%GEN%';

-- Question 2c --
SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- Question 2d -- 
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- Question 3a --
ALTER TABLE actor
ADD description BLOB;

-- Question 3b --
ALTER TABLE actor
DROP COLUMN description;

-- Question 4a --
SELECT last_name, COUNT(*) 
FROM actor
GROUP BY last_name;

-- Question 4b --
SELECT last_name, COUNT(*)
FROM actor 
GROUP BY last_name
HAVING COUNT(*) > 1;

-- Question 4c --
SELECT * FROM actor
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- Question 4d --
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

SELECT * FROM actor
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- Question 5a --
SHOW CREATE TABLE address;

-- Question 6a --
SELECT * FROM staff;
SELECT * FROM address;

SELECT S.first_name, S.last_name, A.address
FROM staff S LEFT JOIN address A ON S.address_id = A.address_id;

-- Question 6b --
SELECT * FROM staff;
SELECT * FROM payment;

SELECT S.staff_id, S.first_name, S.last_name, SUM(P.amount) AS total_amount
FROM staff S LEFT JOIN payment P ON S.staff_id = P.staff_id
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-30'
GROUP BY S.staff_id;

-- Question 6c --
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT F.title, SUM(A.actor_id) AS 'number of actors'
FROM film F INNER JOIN film_actor A ON F.film_id = A.film_id
GROUP BY F.film_id;

-- Question 6d --
SELECT * FROM inventory;
SELECT * FROM film;

SELECT F.title, COUNT(F.title) AS 'copies of the film'
FROM film F INNER JOIN inventory I ON F.film_id = I.film_id
WHERE F.title = 'Hunchback Impossible';

-- Question 6e --
SELECT * FROM payment;
SELECT * FROM customer;

SELECT C.first_name, C.last_name, SUM(P.amount) AS 'total amount paid'
FROM customer C LEFT JOIN payment P ON C.customer_id = P.customer_id
GROUP BY C.customer_id
ORDER BY last_name;

-- Question 7a --
SELECT * FROM film
WHERE language_id = (SELECT language_id FROM LANGUAGE WHERE NAME = 'English') AND (title LIKE 'K%' OR title LIKE 'Q%');

-- Question 7b --
SELECT first_name, last_name FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor
WHERE film_id = (SELECT film_id FROM film
WHERE title = 'Alone Trip'));

-- Question 7c --
SELECT * FROM customer;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM address;

SELECT first_name, last_name, email 
FROM customer LEFT JOIN address ON address.address_id = customer.address_id
WHERE address.address_id IN (SELECT address.address_id 
FROM address LEFT JOIN city ON address.city_id = city.city_id
WHERE city.city_id IN (SELECT city.city_id
FROM city LEFT JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada'));

-- Question 7d --
SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT title FROM film
WHERE film_id IN (SELECT film_id FROM film_category
WHERE category_id = (SELECT category_id FROM category
WHERE name= 'Family'));

-- Question 7e --
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT F.title, COUNT(F.title)
FROM rental R
LEFT JOIN inventory I ON R.inventory_id = I.inventory_id
LEFT JOIN film F ON F.film_id = I.film_id
GROUP BY F.title
ORDER BY COUNT(F.title) DESC;

-- Question 7f --
SELECT * FROM payment;
SELECT * FROM staff;

SELECT S.store_id, SUM (P.amount) AS 'total business in dollars'
FROM staff S 
LEFT JOIN payment P ON S.staff_id = P.staff_id
GROUP BY S.store_id;

-- Question 7g --
SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT S.store_id, C.city, Cy.country
FROM store S 
LEFT JOIN address A ON S.address_id = A.address_id
LEFT JOIN city C ON C.city_id = A.city_id
LEFT JOIN country Cy ON Cy.country_id = C.country_id;

-- Question 7h --
SELECT * FROM category;
SELECT * FROM film_category;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM payment;

SELECT C.name, SUM(P.amount) AS 'top 5 genres'
FROM category C 
LEFT JOIN film_category Fc ON C.category_id = Fc.category_id
LEFT JOIN inventory I ON I.film_id = Fc.film_id
LEFT JOIN rental R ON R.inventory_id = I.inventory_id
LEFT JOIN payment P ON P.rental_id = R.rental_id
GROUP BY C.name
ORDER BY SUM(P.amount) DESC
LIMIT 5;

-- Question 8a --
CREATE VIEW top_5_genres AS
SELECT C.name, SUM(P.amount) AS 'top 5 genres'
FROM category C 
LEFT JOIN film_category Fc ON C.category_id = Fc.category_id
LEFT JOIN inventory I ON I.film_id = Fc.film_id
LEFT JOIN rental R ON R.inventory_id = I.inventory_id
LEFT JOIN payment P ON P.rental_id = R.rental_id
GROUP BY C.name
ORDER BY SUM(P.amount) DESC
LIMIT 5;

-- Question 8b --
SELECT * FROM top_5_genres;

-- Question 8c --
DROP VIEW top_5_genres;









