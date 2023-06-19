create database projects;
use projects;
show tables;
select * from hr;
alter table hr add age int;
update hr set age = timestampdiff(year,birthdate,curdate());
desc hr;

alter table hr modify column termdate date;


update hr set termdate=date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate!='';

update hr set termdate='0000-00-00' where termdate='';

update hr set birthdate=case
when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
else null
end;
select birthdate from hr;

update hr set hire_date=case
when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
else null
end;
select hire_date from hr;





-- Q1 
select gender,count(gender) from hr where age>=18 and termdate='0000-00-00' group by gender;

-- Q2
select race,count(race) from hr where age>=18 and termdate='0000-00-00' group by race;

-- Q3
select max(age) as max_age, min(age) as min_age from hr
where age>=18 and termdate='0000-00-00';
select case
when age>=18 and age <=24 then '18-24'
when age>=25 and age <=34 then '25-34'
when age>=35 and age <=44 then '35-44'
when age>=45 and age <=54 then '45-54'
when age>=55 and age <=64 then '55-64'
end as age_group,
gender,count(*) as count_ from hr
where age>=18 and termdate='0000-00-00'
group by age_group,gender order by age_group;

-- Q4
select location,count(location) from hr where age>=18 and termdate='0000-00-00' group by location;

-- Q5
select round(avg(datediff(termdate,hire_date))/365,1) as avg_length_employeement
 from hr where termdate<=curdate() and termdate<>'0000-00-00' and age>=18;

-- q6
select department,jobtitle,gender,count(*) from hr where age>=18
and termdate='0000-00-00' group by department,gender,jobtitle;

-- q7
select jobtitle,count(jobtitle) from hr where age>=18 and termdate='0000-00-00' group by jobtitle;

-- q8
select department,total_count,terminated_count/total_count as termination_rate 
from
(select department, count(*) as total_count,
sum(case when termdate<>'1000-01-01' and termdate<=curdate() then 1 else 0 end) as terminated_count
from hr
where age>=18
group by department) as sub_query
order by termination_rate desc;

-- q9 
select location_state,count(*) from hr group by location_state;

-- q10
select year_, hires, terminnations, 
 hires-terminnations as net_change,
 round((hires-terminnations)/hires *100, 2) as net_change_percent from
 (select year(hire_date) as year_,
count(*) as hires,
sum(case when termdate<>'1000-01-01' and termdate<=curdate() then 1 else 0 end) terminnations
from hr
where age>=18
group by year(hire_date)) as sub_query
order by year_ asc,net_change_percent desc;

-- q11
select department , round(avg(datediff(termdate,hire_date)/365),0) as tenure from hr
where age >=18 and termdate != "0000-00-00" and termdate<=current_date()
group by department;