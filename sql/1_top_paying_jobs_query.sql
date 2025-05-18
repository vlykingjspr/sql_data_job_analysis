/*
Top paying data analyst job and required skills
-Identify the top 10 highest-paying Data Analyst roles that are available remotely.
-Focuses on job postings with specified salaries(no null value)
-Higlight the top-paying oppurtunities fo D.A. offering insights into employment remote
-Skills required for the top jobs
 */
SELECT
    jpf.job_id,
    jpf.job_title job,
    cd.name company_name,
    COALESCE(STRING_AGG (sd.skills, ', '), 'None') AS skill_required,
    jpf.salary_year_avg salary,
    jpf.job_posted_date posted_date,
    jpf.job_schedule_type job_setup
FROM
    job_postings_fact jpf
    LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
    LEFT JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    jpf.job_id,
    jpf.job_title,
    cd.name,
    jpf.salary_year_avg,
    jpf.job_posted_date,
    jpf.job_schedule_type
ORDER BY
    salary_year_avg DESC
LIMIT
    10;