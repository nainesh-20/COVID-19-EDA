
select *
from PortfolioProject..CovidDeaths
order by 3,4;

select *
from PortfolioProject..CovidVaccinations

-- looking at Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'India';

-- Looking at Total Cases vs Population

SELECT location, date, total_cases, population, (total_cases/population)*100 as Covid_percentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'India'
order by Covid_percentage desc;

-- Comparing India with United States

SELECT location, date, total_cases, population, (total_cases/population)*100 as Covid_percentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
order by 5 desc;


SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY Location
order by TotalDeathCount desc;

-- Grouping by continents

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
order by TotalDeathCount desc;

select * 
from PortfolioProject..CovidDeaths as deaths
join PortfolioProject..CovidVaccinations as vaccinations
on deaths.location = vaccinations.location
and deaths.date = vaccinations.date


select a.continent, a.location, a.population, a.total_cases, b.new_vaccinations, a.date
from PortfolioProject..CovidDeaths as a
join PortfolioProject..CovidVaccinations as b
on a.location = b.location
and a.date = b.date
where a.location = 'India'
order by 6
-- Looking at the query results it looks like covid vaccination in India started from 16th January 2021
-- 1,91,181 people were vaccinated on that day

select a.continent, a.location,  b.new_vaccinations, a.date
from PortfolioProject..CovidDeaths as a
join PortfolioProject..CovidVaccinations as b
on a.location = b.location
and a.date = b.date
where b.new_vaccinations is not null and a.continent is not null
order by a.date
--group by a.location
-- The first vaccination in the world was done in Norway on 8th December 2020. 5 people were vaccinated on that day.


select a.continent, a.location, a.population, a.total_cases, b.new_vaccinations, a.date
from PortfolioProject..CovidDeaths as a
join PortfolioProject..CovidVaccinations as b
on a.location = b.location
and a.date = b.date
where b.new_vaccinations =
(select max(new_vaccinations) from PortfolioProject..CovidVaccinations)
 and a.continent is not null
order by b.new_vaccinations desc



-- queries for tableau visualization
--1.
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(CAST(new_deaths as int))/ sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null

--2.
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International','Upper middle income', 'High income','Lower middle income','Low income')
Group by location
order by TotalDeathCount desc

--3.
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc

--4.

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc