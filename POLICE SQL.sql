Select *
FROM PortfolioPolice..Arrest
order by id

Select *
FROM PortfolioPolice..ID
order by id

-- Shows race and Race count

SELECT Race,COUNT(RACE) as RaceCount
FROM PortfolioPolice..ID
GROUP BY RACE

--Number of Policemen wearing bodycamera when arresting

SELECT body_camera, COUNT(body_camera) AS BodyCamera
FROM PortfolioPolice..ID
Group by body_camera

--Number of people who were Shot or shot or Tasered by the policeman
SELECT name,date,manner_of_death as Cause,COUNT(manner_of_death) AS DeathCount
FROM PortfolioPolice..Arrest
Group by manner_of_death,name,date
ORDER BY DeathCount DESC

--Name, age , gender, race of Police who were Asian and Male

Select a.id,a.name,CONVERT(DATE,a.date),i.age,i.gender,i.race
FROM PortfolioPolice..Arrest a
JOIN PortfolioPolice..ID i
	ON a.id = i.id
WHERE race = 'Asian' and gender = 'M'

--Threat LEVEL and what they were armed with, did they also try to escape
SELECT a.threat_level,a.arms_category,i.flee
FROM PortfolioPolice..Arrest a
JOIN PortfolioPolice..ID i
	ON a.id = i.id


-- What they were armed with total and percentage
SELECT arms_category, count(*) as arms_category_count,
       count(*) * 100.0/ sum(count(*)) over () as arms_percent
FROM PortfolioPolice..Arrest
GROUP BY arms_category

--Name, age , race, city, and state of person who shot
SELECT a.id,a.name,i.race,i.city,i.state,i.age
FROM PortfolioPolice..Arrest a
JOIN PortfolioPolice..ID i
	ON a.id = i.id
Group by a.id,a.name,i.race,i.city,i.state,i.age
ORDER BY i.age DESC

-- STATE,COUNT/PERCENTAGE

SELECT state, count(*) as state_count,
       count(*) * 100.0/ sum(count(*)) over () as state_percent
FROM PortfolioPolice..id
GROUP BY state
ORDER BY state_count DESC
-- Creating a temp table----
DROP TABLE if exists ArmedPercentage
CREATE TABLE ArmedPercentage
(arms_category nvarchar(255),
arms_category_count int,
arms_percent float
)
Insert into ArmedPercentage
SELECT arms_category, count(*) as arms_category_count,
       count(*) * 100.0/ sum(count(*)) over () as arms_percent
FROM PortfolioPolice..Arrest
GROUP BY arms_category

Select *
FROM ArmedPercentage



-- ---------------------------------------------------------Creating Views-----------------------------------------------------------------------------------

Create view ArmedTotal as
SELECT arms_category, count(*) as arms_category_count,
       count(*) * 100.0/ sum(count(*)) over () as arms_percent
FROM PortfolioPolice..Arrest
GROUP BY arms_category

------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as
SELECT a.id,a.name,i.race,i.city,i.state,i.age
FROM PortfolioPolice..Arrest a
JOIN PortfolioPolice..ID i
	ON a.id = i.id
Group by a.id,a.name,i.race,i.city,i.state,i.age
------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as
Create view Danger as 
SELECT a.threat_level,a.arms_category,i.flee
FROM PortfolioPolice..Arrest a
JOIN PortfolioPolice..ID i
	ON a.id = i.id
------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as
Create view Asian as
Select a.id,a.name,CONVERT(DATE,a.date) as date,i.age,i.gender,i.race
FROM PortfolioPolice..Arrest a
JOIN PortfolioPolice..ID i
	ON a.id = i.id
WHERE race = 'Asian' and gender = 'M'
------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as
Create view Shot as 
SELECT name,date,manner_of_death as Cause,COUNT(manner_of_death) AS DeathCount
FROM PortfolioPolice..Arrest
Group by manner_of_death,name,date
------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as
Create view Camera as 
SELECT body_camera, COUNT(body_camera) AS BodyCamera
FROM PortfolioPolice..ID
Group by body_camera
------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as
Create view Racecount as
SELECT Race,COUNT(RACE) as RaceCount
FROM PortfolioPolice..ID
GROUP BY RACE
------------------------------------------------------------------------------------------------------------------------------
Create View InfoPolice as

exec sp_refreshview Danger
go
select * from Danger