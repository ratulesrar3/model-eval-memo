create schema dmh;


create table dmh.persons (
	person_id bigint primary key not null,
	sex varchar,
	race varchar,
	age numeric,
	dmh_visit_date date, 
	homeless int,
	m1_pred_prob numeric,
	m2_pred_prob numeric
);


create table dmh.arrests (
	person_id bigint references dmh.persons(person_id),
	arrest_date date
);


COPY dmh.persons(person_id,sex,race,age,dmh_visit_date,homeless,m1_pred_prob,m2_pred_prob) 
FROM '/Users/ratulesrar/Google Drive/CPL Data Science Assessment/dmh.csv' DELIMITER ',' CSV HEADER;


COPY dmh.arrests(person_id,arrest_date) 
FROM '/Users/ratulesrar/Google Drive/CPL Data Science Assessment/sheriff.csv' DELIMITER ',' CSV HEADER;


-- Q1
select homeless,
	   sum(prior_arrest) as arrest_count, 
	   sum(cast(prior_arrest as float)) / (select count(*) from dmh.persons) as prior_arrest_rate
from (
	select p.person_id,
		   homeless,
		   case
		     when first_arrest_date < dmh_visit_date then 1 else 0
		   end as prior_arrest
	from dmh.persons p
	  left join (select person_id,
	  					min(arrest_date) as first_arrest_date 
	  			from dmh.arrests 
	  			group by person_id) a 
	  	on a.person_id = p.person_id) sub
group by homeless;


-- Q2
select race,
	   min(days_between) as min_days_between,
   	   max(days_between) as max_days_between,
   	   avg(days_between) as avg_days_between
from (
	select p.person_id,
		   arrest_date,
		   race,
		   (dmh_visit_date - arrest_date) as days_between,
		   row_number() over (partition by p.person_id order by arrest_date desc) as recency_rank
	from dmh.arrests a
	left join dmh.persons p on a.person_id = p.person_id
	where arrest_date < dmh_visit_date) sub
where recency_rank = 1
group by race;


-- Q3
select person_id, 
	   arrest_date,
	   prev_arrest_date,
	   (arrest_date - prev_arrest_date) as days_between_arrest,
	   case when (arrest_date - prev_arrest_date) = 1 then 1 else 0 end as consecutive_arrest
from (
	select person_id,
		   lag(arrest_date, 1) over (partition by person_id order by arrest_date) as prev_arrest_date,
		   arrest_date
	from dmh.arrests) a
where prev_arrest_date is not null
order by consecutive_arrest desc, person_id;