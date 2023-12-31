select * from hr;

-- data cleaning --
--- changing column name ------
alter table hr
change column ï»¿id emp_id varchar(20) null;

describe hr;

--- changing birthdate format and datatype ----
update hr
set birthdate = case
	  when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
	  when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    else null
    end;
     
alter table hr
modify column birthdate date;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    else null
    end;
    
alter table hr
modify column hire_date date;

set sql_safe_updates = 0;

update hr
set termdate = null
where termdate = '';

alter table hr
add column age int;

update hr
set age = timestampdiff(year,birthdate,curdate());

select min(age), max(age)
from hr;

-- gender breakdown --
select gender,count(*) as count
from hr
where termdate is null
group by gender;

-- what is average length of employement who have been terminated --
select round(avg((termdate) - year(hire_date)),0) as length_of_emp
from hr
where termdate is not null and termdate<= curdate();

-- how does gender distribution varies across department? --
select department,jobtitle,gender,count(*) as count
from hr
where termdate is not null
group by department,jobtitle,gender
order by department,jobtitle,gender;

-- race breakdown --
select race, count(*) as count
from hr
where termdate is null
group by race;

-- age distribution in company --

select
 case
      when age >= 18 and age <= 24 then '18-24'
	  when age >= 25 and age <= 34 then '25-34'
	  when age >= 35 and age <= 44 then '35-44'
	  when age >= 45 and age <= 54 then '45-54'
      else '55+'
end as'age_grp',count(*) as count
from hr
where termdate is null
group by age_grp
order by age_grp;
-- 





