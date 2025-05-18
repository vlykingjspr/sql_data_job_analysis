/*
Skills that required for the top-paying data analyst job?
-Use the top 10 highest paying jobs from the first query
-Add the specific skills required for these roles
-To provide a detailed look at which high paying jobs demand certain skills
 */
WITH
    top_paying_job AS (
        SELECT
            jpf.job_id,
            jpf.job_title job,
            cd.name company_name,
            jpf.salary_year_avg salary,
            jpf.job_posted_date posted_date
        FROM
            job_postings_fact jpf
            LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
        WHERE
            job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
            AND job_location = 'Anywhere'
        ORDER BY
            salary_year_avg DESC
        LIMIT
            10
    )
SELECT
    skills,
    top_paying_job.*
FROM
    top_paying_job
    INNER JOIN skills_job_dim sjd ON top_paying_job.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
    salary DESC;

/*
This analysis explores the top-paying Data Analyst jobs and the specific skills driving their high salaries. By examining the highest-paid roles, we identify key technical proficiencies—such as SQL, Python, and Tableau—that form the foundation of lucrative data analyst careers. Additionally, skills like Excel, AWS, Power BI, and data manipulation libraries (Pandas, NumPy) are linked to even higher salary brackets, highlighting their growing importance. The findings underscore the value of combining core programming, data visualization, cloud technologies, and collaboration tools to maximize earning potential in the data analytics field.

SQL, Python, and Tableau are the most frequently required skills, highlighting their foundational role in data analysis.

Despite being less frequently listed, Excel, R, and Pandas are tied to high average salaries—around PHP 215K+, showing their strong value.

AWS and Power BI are linked to the highest average monthly salaries (PHP 222K), reflecting high demand for cloud and business intelligence skills.

Tools like Snowflake, Oracle, NumPy, and Go also appear, but with slightly lower salary associations (PHP 190K–200K range).

Version control and collaboration tools such as GitLab, Atlassian, and Confluence are less frequent but still relevant, especially in team-based environments.

Key Strategy: Focus on mastering the top 3—SQL, Python, Tableau—while also building expertise in Excel, AWS, Power BI, and data manipulation libraries (Pandas, NumPy) to qualify for higher-paying roles.
🧠 Key Insights:
Core Programming and Data Tools Dominate:

SQL and Python are the most in-demand, forming the backbone of data querying and analysis.

R, Pandas, and NumPy show additional demand for statistical computing and data wrangling.

Data Visualization Tools Matter:

Tableau and Power BI are highly valued—jobs requiring them tend to offer higher salaries.

Cloud and Big Data Skills Pay More:

Skills like AWS, Snowflake, and Databricks (not shown in top 15 but included in dataset) correlate with top-tier salaries, suggesting companies value cloud-based data engineering experience.

Excel Still Has a Strong Role:

Despite being a traditional tool, Excel-related roles still pay very well, especially when combined with modern tools.

Collaboration and DevOps Tools (Atlassian, GitLab):

These skills are likely relevant in teams with complex workflows, version control, and agile practices.
 */