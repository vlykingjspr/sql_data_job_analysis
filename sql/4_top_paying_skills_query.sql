/*
What are the top skills based on salary?
- Look at the average salary associated with each skills for DA positions
- Focuses on roles with specified salaries, regardless of location
- To reveal how different skills impact salary levels for Data Analyst and helps identify the most financially rewarding skills to acquire or improve
 */
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) average_salary
FROM
    job_postings_fact as jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Philippines'
GROUP BY
    skills
HAVING
    AVG(salary_year_avg) IS NOT NULL
ORDER BY
    average_salary DESC
LIMIT
    10