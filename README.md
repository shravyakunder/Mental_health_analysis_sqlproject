# Mental_health_analysis_sqlproject

This project analyzes a dataset containing psychological traits, specifically social anxiety and autistic traits scores, collected from various individuals. The goal is to extract meaningful insights about trends, correlations, and distributions based on different demographic and psychological dimensions. The data is stored in a table called traits, which includes attributes like age, gender, social anxiety scores, autistic traits scores, and possibly timestamps of data collection.

Project Objectives
1. Identify users with high scores in both social anxiety and autistic traits.
2. Explore how these traits vary by gender.
3. Analyze the correlation between the two traits.
4. Examine score ranges across the dataset.
5. Understand trait distributions across age groups.
6. Identify individuals with the highest social anxiety.
7. Assess data quality through missing data checks.
8. Analyze score trends over time.
9. Analyse Average Trait Scores by Ethnicity.

 Project Structure
1. Database Table: traits
2. Key Columns:
    * age
    * gender
    * social_anxiety_score
    * autistic_traits_score
    
-- DATA CLEANING 
1. Checking for missing data
SELECT * 
FROM traits
WHERE 
    ID IS NULL
    OR Age IS NULL
    OR Gender IS NULL
    OR Ethnicity IS NULL
    OR Social_anxiety_score IS NULL
    OR Autistic_traits_score IS NULL;

2. Removing incorrect data
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


Key Findings Summary
1. Significant High Scores in Both TraitsA notable subset of individuals exhibit high levels of both social anxiety and autistic traits, potentially indicating comorbid psychological conditions that may require clinical attention.
2. Gender-Based Differences in AveragesTrait scores vary by gender, with females and non-binary individuals generally showing higher average social anxiety levels than males, suggesting the importance of gender-sensitive mental health approaches.
3. Positive Correlation Between TraitsScatter-friendly data reveals a positive correlation between social anxiety and autistic traits—individuals with high scores in one trait often have elevated scores in the other.
4. Majority Age Group: 19–30 YearsMost of the dataset falls within the 19–30 age group, highlighting this segment as the most engaged or affected demographic, and a key target for interventions or studies.
5. Ethnicity-Based Variations in ScoresEthnic groups like Asian (British) and Indian are highly represented. Some groups (e.g. Irish) show higher average scores, although these results should be interpreted cautiously if sample sizes are small.
6. Clean and High-Quality DatasetThe dataset has minimal missing data and includes a balanced distribution of scores, making it suitable for statistical analysis, visualization, and predictive modeling.

Conclusion
This SQL-based exploratory analysis has successfully:
* Highlighted individual and group-level psychological patterns
* Identified areas for potential clinical focus
* Assessed data quality and readiness for deeper analysis

Further work could include:
* Regression modeling for predictive insights
* Visualization using tools like Tableau or Python (matplotlib/seaborn)
* Deeper demographic analysis combining age, gender, and traits


