show tables;
-- create a join table
select * 
from  absenteeism_at_work a
left join compensation c on a.ID = c.ID
left join reasons r on a.`Reason for absence` = r.Number;
select * 
from absenteeism_at_work
where `Social drinker`=0 and `social smoker`=0;

-- Find healthiest employees to give 1000$ bonus
select * 
from absenteeism_at_work
where `Social drinker`=0 and `social smoker`=0
and `Body mass index` <25 and
`Absenteeism time in hours`< (select avg(`Absenteeism time in hours`) from absenteeism_at_work);

-- compensation or wage increase for non_smoker budget = $983,221
select count(*) as nonsmokers from absenteeism_at_work
where `Social smoker`=0;
-- emp= 686 , 5 days a week* 8 hrs a day *52 week per year =  2080 hrs year work * 686 = 1,426,880
-- therefore  983221/1,426,880 = 0.6890   that is 68 cent increase per hour 
-- $1414 per year for non smoker

-- optimize
select a.ID, r.Reason, Seasons,`Day of the week`,`Transportation expense`,`Education`,Son,`Social drinker`,`Social smoker`,Pet,`Disciplinary failure`,
 Age,`Work load Average/day`,`Absenteeism time in hours`,
case
    when `Body mass index` <18.5 then 'Underweight'
	when `Body mass index` between 18.5 and 25 then 'Healthy'
	when `Body mass index` between 25 and 30 then 'Overweight'
	when `Body mass index` >30 then 'Obese'
	else 'unknown' END BMI_category, 
case 
     when `Month of absence` in (12,1,2) then 'Winter'
	 when `Month of absence` in (3,4,5) then 'Spring'
     when `Month of absence` in (6,7,8) then 'Summer'
	 when `Month of absence` in (9,10,11) then 'Fall'
     else 'unknown' END season_name
from  absenteeism_at_work a
left join compensation c on a.ID = c.ID
left join reasons r on a.`Reason for absence` = r.Number;
