-- Question 1
Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 1
INTERSECT
Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 2
order by title asc;

Select title 
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 1
UNION
Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 2
order by title asc;

Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 1
MINUS
Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 2
order by title asc;

Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 2
MINUS
Select title
from film INNER JOIN Inventory on film.film_id = inventory.film_id 
where inventory.store_id = 1
order by title asc;

-- Question 2
Select distinct title
from film inner join inventory on film.film_id = inventory.film_id
where inventory.store_id = 1 AND title in (Select title from film inner join inventory on film.film_id = inventory.film_id where inventory.store_id = 2)
order by title asc;

Select distinct title
from film inner join inventory on film.film_id = inventory.film_id
where inventory.store_id = 1 OR inventory.store_id = 2
order by title asc;

SELECT DISTINCT title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.store_id = 1
AND NOT EXISTS (
    SELECT 1 FROM inventory 
    WHERE inventory.film_id = film.film_id AND inventory.store_id = 2)
ORDER BY title ASC;

SELECT DISTINCT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.store_id = 2
AND film.film_id NOT IN (
    SELECT film_id 
    FROM inventory 
    WHERE store_id = 1 and film_id is not null) -- had to add to return results
ORDER BY film.title ASC;

-- Question 3
SELECT film.title
FROM film
where rental_rate > (select avg(rental_rate)
from film);

-- Question 4
SELECT film.rating
FROM film
Group by rating
having avg(rental_rate) > (select avg(rental_rate)
from film);

-- Question 5
select film.film_id, film.title, count(film_actor.actor_id)
from film inner join film_actor on film.film_id = film_actor.film_id
Group by film.film_id, film.title
Order by count(film_actor.actor_id) asc;

select film.film_id, film.title, count(film_actor.actor_id)
from film inner join film_actor on film.film_id = film_actor.film_id
Group by film.film_id, film.title
Order by count(film_actor.actor_id) asc
FETCH First 1 ROWS ONLY;

select film.film_id, film.title, count(film_actor.actor_id)
from film inner join film_actor on film.film_id = film_actor.film_id
Group by film.film_id, film.title
Order by count(film_actor.actor_id) asc;

Select film.film_id, film.title, count(film_actor.actor_id),
CASE
    when count(film_actor.actor_id) > 12 THEN 'Big Production'
    when count(film_actor.actor_id) > 8 THEN 'Fair'
    when count(film_actor.actor_id) > 5 THEN 'Small'
    else 'Budget'
End as productiction_size
from film inner join film_actor on film.film_id = film_actor.film_id
Group by film.film_id, film.title
Order by count(film_actor.actor_id) asc;

Select production_size, count(*) AS film_count
From (select 
        CASE
        when count(film_actor.actor_id) > 12 THEN 'Big Production'
        when count(film_actor.actor_id) > 8  THEN 'Fair'
        when count(film_actor.actor_id) > 5  THEN 'Small'
        else 'Budget'
        end as production_size
    FROM film inner join film_actor on film.film_id = film_actor.film_id
    Group by film.film_id, film.title)
Group by production_size;