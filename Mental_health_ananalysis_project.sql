CREATE DATABASE mental_health;

-- CREATE TABLE 
CREATE TABLE traits (
ID INT PRIMARY KEY,
Age INT,
Gender VARCHAR(15),
Ethnicity VARCHAR(20),
Social_anxiety_score FLOAT,
Autistic_traits_score FLOAT
);

-- DATA CLEANING 
SELECT * 
FROM traits
WHERE 
    ID IS NULL
    OR Age IS NULL
    OR Gender IS NULL
    OR Ethnicity IS NULL
    OR Social_anxiety_score IS NULL
    OR Autistic_traits_score IS NULL;

DELETE FROM traits
WHERE 
    Age < 0 OR Age > 120
    OR Social_anxiety_score < 0 OR Social_anxiety_score > 100
    OR Autistic_traits_score < 0 OR Autistic_traits_score > 100;

-- DATA ANALYSIS 
-- Q.1 Write a SQL query to find users with high scores in both areas.
SELECT * FROM traits
WHERE social_anxiety_score > 30 AND autistic_traits_score > 50;

-- Q.2 Write a SQL query to find average scores grouped by gender.
SELECT gender,
       AVG(social_anxiety_score) AS avg_sa,
       AVG(autistic_traits_score) AS avg_autism
FROM traits
GROUP BY gender;

-- Q.3 Write a SQL query to check correlation visually (scatter-friendly data).
SELECT social_anxiety_score, autistic_traits_score
FROM traits
WHERE social_anxiety_score IS NOT NULL AND autistic_traits_score IS NOT NULL;


-- Q.4 Write a SQL query to Get score ranges (min, max, avg)
SELECT
  CASE
    WHEN age BETWEEN 0 AND 18 THEN '0-18'
    WHEN age BETWEEN 19 AND 30 THEN '19-30'
    WHEN age BETWEEN 31 AND 50 THEN '31-50'
    ELSE '51+'
  END AS age_group,
  COUNT(*) AS total
FROM traits
GROUP BY age_group;

-- Q.5 Write a SQL query to get top 10 individuals with the highest social anxiety scores
SELECT * 
FROM traits
ORDER BY social_anxiety_score DESC
LIMIT 10;

-- Q.6 Write a SQL query to check missing data
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN social_anxiety_score IS NULL THEN 1 ELSE 0 END) AS missing_sa,
    SUM(CASE WHEN autistic_traits_score IS NULL THEN 1 ELSE 0 END) AS missing_autism
FROM traits;

-- Q.7 Write a SQL query to find dentify individuals with Low Scores in Both Traits
SELECT * 
FROM traits
WHERE social_anxiety_score < 25 AND autistic_traits_score < 35;

-- Q.8 Write a SQL query to find average Trait Scores by Ethnicity
SELECT 
  Ethnicity,
  COUNT(*) AS total_individuals,
  AVG(Social_anxiety_score) AS avg_social_anxiety,
  AVG(Autistic_traits_score) AS avg_autistic_traits
FROM traits
GROUP BY Ethnicity
ORDER BY total_individuals DESC;
