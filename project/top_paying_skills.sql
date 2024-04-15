/*
Qustion: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst postitions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analyst and 
       helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    ROUND(AVG(salary_year_avg),0) AS average_slary_for_skill,
    skills_dim.skills AS skill
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY skill
ORDER BY average_slary_for_skill DESC
LIMIT 25;
