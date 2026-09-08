-- Question 1
Select Actor_ID, First_name, Last_name
    From ACTOR
Order by last_name asc, first_name asc;

Select Actor_ID, First_name, Last_name
    From ACTOR
Order by last_name asc, first_name desc;

Select Actor_ID, First_name, Last_name
    From ACTOR
Order by First_name asc, Last_name asc;

-- Question 2
Select 2 * 3
    From Dual;

Select 5 + 7
    From Dual;
    
-- Question 3
Select count(city_id) AS total_cities
    From City;

Select country_id,count(city_id) AS total_cities
    From City
Group by country_id;

-- Question 4
Select country_id,count(city_id) AS total_cities
    From City
Group by country_id
Having count(city_id) > 50;

Select country_id,count(city_id) AS total_cities
    From City
Group by country_id
Having count(city_id) > 50
Order By count(city_id) asc;


-- Question 5
Select count(film_id), release_year
    From film
Group by release_year;

Select count(film_id), release_year, rating
    From film
Where rating in ('PG')
Group by release_year,rating;

Select count(film_id), release_year
    From film
Where release_year > 2015
Group by release_year;

Select count(film_id), release_year
    From film
Group by release_year
Having count(film_id) > 50;

Select count(film_id), release_year, rating
    From film
Where release_year = 2015
Group by release_year, rating;

Select round(avg(rental_rate),2) AS avg_rental_rate, max(rental_duration) AS max_rental_duration, rating
    From film
Group by rating;

-- Question 6
Select city.city, country.country
    From city, country
Where city.country_id = country.country_id;

Select city.city, country.country
    From city INNER JOIN country on city.country_id = country.country_id;
    
Select city.city, country.country -- This returns a blank result this is because it tries to match column by column and that is not done properly
    From city natural join country;
    
-- Question 7
Select country.country, city.city
    From city INNER JOIN Country on country.country_id = city.country_id;
    
Select country.country, count(city.city)
    From city INNER JOIN Country on country.country_id = city.country_id
Group by country.country;

-- Question 8
Select film.title, language.name
    From film, language
Where film.original_language_id = language.language_id;

Select film.title, language.name
    From film INNER JOIN language on film.original_language_id = language.language_id;
    
Select film.title, language.name -- This returns a blank result this is because it tries to match column by column and that is not done properly
    From film NATURAL JOIN language;
    
Select film.title, language.name, NVL(TO_CHAR(film.original_language_id), 'No Original Language Reported') AS Original_Language
    From film LEFT OUTER JOIN language on film.original_language_id = language.language_id;
    
Select film.title, language.name
    From film LEFT OUTER JOIN language on film.original_language_id = language.language_id
Where film.original_language_id is null;

Select NVL(film.title, 'N/A') as Title, language.name
    From film RIGHT OUTER JOIN language on film.original_language_id = language.language_id;
    
Select language.name
    from language LEFT OUTER JOIN film on film.language_id = language.language_id
Where film.language_id is null
Group by language.name;

-- Question 9
Select film.title, count(inventory_id)
    From film left outer join inventory on film.film_id = inventory.film_id
Group by film.title;

Select film.title, count(inventory_id), inventory.store_id
    From film left outer join inventory on film.film_id = inventory.film_id
Group by film.title, inventory.store_id
Order by inventory.store_id;

Select film.title, count(inventory_id)
    From film left outer Join inventory on film.film_id = inventory.film_id
Group by film.title;

-- Question 10
SELECT film.title, category.name
FROM film_category INNER JOIN category ON film_category.category_id = category.category_id
INNER JOIN film ON film_category.film_id = film.film_id;

SELECT film.title, category.name
FROM film_category LEFT JOIN category ON film_category.category_id = category.category_id
INNER JOIN film ON film_category.film_id = film.film_id;
--where film_category.category_id is null;

SELECT film.title, category.name
FROM film_category LEFT OUTER JOIN category ON film_category.category_id = category.category_id
LEFT OUTER JOIN film ON film_category.film_id = film.film_id;

-- Question 11
SELECT film.title, category.name, COUNT(inventory.inventory_id)
FROM film_category LEFT OUTER JOIN category ON film_category.category_id = category.category_id
LEFT OUTER JOIN film ON film_category.film_id = film.film_id
LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title, category.name;

SELECT film.title, category.name, COUNT(inventory.inventory_id)
FROM film LEFT OUTER JOIN film_category ON film.film_id = film_category.film_id
LEFT OUTER JOIN category ON film_category.category_id = category.category_id
LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title, category.name;

SELECT film.title, category.name, COUNT(inventory.inventory_id)
FROM film INNER JOIN inventory ON film.film_id = inventory.film_id
LEFT OUTER JOIN film_category ON film.film_id = film_category.film_id
LEFT OUTER JOIN category ON film_category.category_id = category.category_id
GROUP BY film.title, category.name;