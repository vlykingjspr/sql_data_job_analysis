/*
What are the most optimal skills to learn (high demand and high paying)
- Identify skills in high demand and associate with high average salaries for data analyst roles
- Concentrates on remote positions with specified salaries
- To target skills that offer job securit and financial benefits 
 */
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) demand_count,
    ROUND(AVG(jpf.salary_year_avg), 2) average_salary
FROM
    job_postings_fact as jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT
    10