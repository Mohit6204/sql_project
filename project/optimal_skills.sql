/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benifits (high salaries),
       offering strategic inshights for carrer development in data analysis
*/
WITH demand_skills AS (
    SELECT
        COUNT(skills_job_dim.job_id) AS number_of_job_posting,
        skills_dim.skills AS skill,
        skills_dim.skill_id
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location='Anywhere'
    GROUP BY skills_dim.skill_id
), average_salary AS (
    SELECT
        ROUND(AVG(salary_year_avg),0) AS average_slary_for_skill,
        skills_dim.skills AS skill,
        skills_dim.skill_id
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location='Anywhere'
    GROUP BY skills_dim.skill_id
)

SELECT
    demand_skills.skill_id,
    demand_skills.number_of_job_posting,
    demand_skills.skill,
    average_salary.average_slary_for_skill
FROM demand_skills
INNER JOIN average_salary ON demand_skills.skill_id=average_salary.skill_id
WHERE 
    number_of_job_posting>10
ORDER BY
    average_slary_for_skill DESC,
    number_of_job_posting DESC
LIMIT 25;