-- Question 1
Select film.title, category.name, count(inventory.inventory_id) as Inventory
    From film INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN Category ON film_category.category_id = category.category_id
    LEFT JOIN inventory ON film.film_id = inventory.film_id
Group by film.title, category.name;

Select film.title, category.name, count(inventory.inventory_id) as Inventory
    From film LEFT OUTER JOIN film_category ON film.film_id = film_category.film_id
    LEFT OUTER JOIN Category ON film_category.category_id = category.category_id
    LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
Group by film.title, category.name;


Select film.title, category.name, count(inventory.inventory_id) as Inventory
    From film LEFT OUTER JOIN film_category ON film.film_id = film_category.film_id
    LEFT OUTER JOIN Category ON film_category.category_id = category.category_id
    INNER JOIN inventory ON film.film_id = inventory.film_id
Group by film.title, category.name;


-- Question 2
Select f1.film_id AS OG_Movie, f1.title AS OG_TITLE,f2.film_id AS Sequel, f2.title AS Sequel_Title
    From film f1 INNER JOIN film f2 ON f1.film_id = f2.sequel;
    
Select f1.film_id AS OG_Movie, f1.title AS OG_TITLE,f2.film_id AS Sequel, f2.title AS Sequel_Title
    From film f1 INNER JOIN film f2 ON f1.film_id = f2.sequel
Where f1.rating != f2.rating;

Select f1.film_id AS OG_Movie, f1.title AS OG_TITLE,nvl(f2.film_id, 0) AS Sequel, nvl(f2.title ,'Nothing to see here')AS Sequel_Title
    From film f1 LEFT OUTER JOIN film f2 ON f1.film_id = f2.sequel;
    
-- Question 3
Select film.title
    From film INNER JOIN Inventory on film.film_id = inventory.film_id
Group by film.title
Order by film.title asc;

Select film.title
    From film
Where film_id IN (Select film_id From Inventory)
Order by film.title asc;

Select film.title
    From film
Where film_id IN (Select inventory.film_id From inventory where film.film_id = inventory.film_id)
Order by film.title asc;


Select film.title
    From film
Where EXISTS (Select inventory.film_id From inventory where film.film_id = inventory.film_id)
Order by film.title asc;

--Question 4
Select film.title
    From film LEFT JOIN Inventory on film.film_id = inventory.film_id
    Where inventory.film_id is NULL
Order by film.title asc;

Select film.title
    From film
Where film_id NOT IN (Select film_id From Inventory)
Order by film.title asc;

Select film.title
    From film
Where film.film_id NOT IN (Select inventory.film_id From inventory where film.film_id = inventory.film_id)
Order by film.title asc;

Select film.title
    From film
Where NOT EXISTS (Select inventory.film_id From inventory where film.film_id = inventory.film_id)
Order by film.title asc;

-- Question 5
/*
With the new null added values to the table it makes so that Query B and C
give different results, they do not show up in the results clearly but you can tell
because the IN keyword does not work perfectly with nulls
*\
