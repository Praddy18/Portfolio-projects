select * from listlondon;

-- Projected income of top airbnb hosts for next 30 days --
select id,host_name, 30 - availability_30 as 'booked_for_30', 
cast(Replace(price,'$','')as unsigned ) as 'price_clean',
cast(Replace(price,'$','')as unsigned )*( 30 - availability_30) as 'projected_income'
from listlondon
order by projected_income desc
limit 10 ;
 
 -- Best Airbnb property in the town --
select * 
from listlondon
where number_of_reviews > 60 and review_scores_rating >4.6
order by review_scores_rating desc
limit 10;

-- show townhouses in city --
select * 
from listlondon
where property_type like '%townhouse%'; 

