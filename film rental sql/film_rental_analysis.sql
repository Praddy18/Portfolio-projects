select * from inventory;
select * from rental;
select * from film;
select * from store;
select * from payment;


-- how many times each movie has been rented out--
select f.film_id,f.title,count(i.film_id)as 'total_number_of_rentals'
from rental r
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
group by i.film_id;

-- revenue per movie --
select f.film_id,f.title,count(i.film_id)as 'total_number_of_rentals', f.rental_rate, count(i.film_id)* f.rental_rate as 'revenue_per_movie'
from rental r
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
group by i.film_id;

-- revenue by stores --
 select s.store_id, sum(p.amount) as 'revenue-by_store'
 from store s
 join inventory i on i.store_id = s.store_id
 join rental r on r.inventory_id = i.inventory_id
 join payment p on p.customer_id = r.customer_id
 group by 1
 order by 2 desc;
 
 -- which rating has most number of films in each store

select s.store_id,f.rating,count(f.rating) as 'number_of_films'
from store s
join inventory i on i.store_id = s.store_id
join film f on f.film_id = i.film_id
group by 1,2
order by 2 desc;


 


