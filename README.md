# 📊 Introduction

Welcome to this SQL-powered analysis of the 2023 data analyst job market! This project dives into real-world job posting data to uncover insights into compensation trends, skill demands, and the most optimal skills to learn in today’s competitive market.

In today’s competitive and rapidly evolving job market, staying aligned with industry trends is crucial. This project offers data-driven insights to help learners, professionals, and career shifters focus on the most valuable skills for success in the data analytics field.

# 🧩 Background

As the demand for data analysts continues to grow across industries, it's increasingly important to understand which skills lead to the best career opportunities. With thousands of job postings listing varying qualifications and salary ranges, it can be challenging to identify where to focus your learning efforts.

The goal is to help aspiring data analysts (like myself) make data-driven decisions about their career development.

Questions Answered
Using SQL queries, I answered the following key questions:

- 💼 What are the top-paying data analyst jobs and what skills do they require?

- 🧠 What are the most in-demand skills for data analysts overall?

- 💸 Which skills are most strongly associated with higher salaries?

- 🚀 What are the most optimal skills to learn right now to boost employability and income potential?

Whether you're starting out in the data field or planning your next move, this analysis provides valuable insights into where the industry is heading and how to stay competitive.

# 🛠 Tools Used

- **SQL** – For querying and analyzing job market data

- **PostgreSQL** – As the database management system

- **Visual Studio Code** – Code editor for writing and testing SQL queries

- **Git**– For version control

- **GitHub** – For project hosting and collaboration
<div align="left">
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/postgresql/postgresql-original.svg" height="40" alt="postgresql logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original.svg" height="40" alt="mysql logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg" height="40" alt="vscode logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg" height="40" alt="git logo"  />
  <img width="12" />
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/github/github-original.svg" height="40" alt="github logo"  />
</div>

##

# 📈 Analysis Overview

This analysis leverages structured SQL queries to explore job posting data for data analyst roles in 2023. Each query was designed to extract specific insights from the dataset—ranging from identifying the top-paying positions to determining which technical and analytical skills are most in demand.

### 🔎 Query 1: Top-Paying Remote Data Analyst Jobs

This query identifies the top 10 highest-paying remote Data Analyst job postings with specified (non-null) salaries. It also highlights the required skills for each role, providing a snapshot of premium job opportunities in the remote job market.

```sql
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
```

In remote Data Analyst roles, the highest is “Data Analyst” at $650,000, followed by “Director of Analytics” at $336,500. Other full-time roles include “Associate Director–Data Insights,” “Data Analyst, Marketing,” and “Principal Data Analyst (Remote).”

![Top Paying Roles](assets/1_top_paying_roles.png)

_Bar graph visualizing the salary for the top 10 salaries for data analyst._

### 🔎 Query 2: Skill for Top-Paying Data Analyst Job

To provide a detailed look at which high-paying data analyst jobs demand specific skills and highlight the key competencies driving top salaries.

```SQL
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

```

Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- SQL is leading with a bold count of 8.
- Python follows closely with a bold count of 7.
- Tableau is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

![Top Paying Skill for Data Analyst](assets/2_top_paying_roles_skills.png)

_Bar graph visualizing the frequency of skills for the top 10 skills for data analyst._

### 🔎 Query 3: Indemand skills for Data Analyst

This query reveals the most sought-after skills in data analyst job listings, helping to pinpoint the areas with the greatest demand.

```sql
SELECT
    sd.skills,
    COUNT(sjd.job_id) demand_count
FROM
    job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Philippines'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT
    5
```

SQL and Excel continue to be essential, underscoring the importance of strong fundamentals in data management and spreadsheet expertise. Meanwhile, programming and visualization tools such as Python, Tableau, and Power BI have become critical, reflecting the growing need for technical proficiency in data analysis and presentation.

Below is a summary of the top skills required for data analysts in 2023:

| Skills   | Demand Count |
| -------- | ------------ |
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

_Table showing the top 5 most in-demand skills for data analyst roles._

### 🔎 Query 4: Skill Based on Salary

This query highlights how various skills influence salary levels for data analysts and helps pinpoint the most financially rewarding skills to learn or enhance.

```sql
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
```

An analysis of average salaries linked to various technical skills reveals which capabilities are most valuable in the data analytics field.

- Big Data & ML Skills Pay More: Tools like PySpark, Couchbase, DataRobot, and Jupyter command top salaries due to their role in advanced analytics and predictive modeling.

- Engineering Tools Add Value: Skills in GitLab, Kubernetes, and Airflow boost earnings by enabling scalable, automated data workflows.

- Cloud Expertise Boosts Pay: Knowledge of Elasticsearch, Databricks, and GCP is highly valued for supporting cloud-based analytics environments.

| Skills        | Average Salary ($) |
| ------------- | -----------------: |
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

_Table of the average salary for the top 10 paying skills for data analysts_

### 🔎 Query 5: Most Optimal Skills to Learn

This query identifies the top 10 most optimal skills to learn—those that are both in high demand and associated with high average salaries for data analyst roles. It focuses on remote positions with listed salaries, helping to pinpoint skills that offer strong job security and financial rewards.

```sql
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
```

**Top In-Demand Skills for Data Analysts in 2023**

- **Programming Languages:** Python and R remain highly sought-after, with strong demand and average salaries around $100K, showing their widespread use and value.

- **Cloud Technologies:** Tools like Snowflake, Azure, AWS, and BigQuery offer both high demand and competitive pay, reflecting the shift toward cloud-based analytics.

- **BI & Visualization:** Tableau and Looker are key for turning data into insights, with solid demand and salaries near $100K.

- **Databases:** Skills in Oracle, SQL Server, and NoSQL continue to be essential, offering stable demand and salaries up to $104K.

| Skill ID | Skills     | Demand Count | Average Salary ($) |
| -------- | ---------- | ------------ | -----------------: |
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

_Table of the most optimal skills for data analyst sorted by salary_

# 🚀 What I Learned

🔍 **Advanced SQL Mastery:** Cracked the code on writing powerful queries—think multi-table joins, nested subqueries, and those slick CTEs (WITH clauses) that make complex logic clean and readable.

📈 **Summarizing Like a Pro:** Harnessed the full force of GROUP BY, COUNT(), AVG(), and more to slice, dice, and summarize data with precision.

🧠 Real-World Problem Solving: Transformed business questions into sharp, efficient SQL solutions—gaining the confidence to tackle real-world data challenges head-on.

# Conclusion

### 📌 Key Insights from the Analysis

- **Highest-Paying Remote Roles:** Remote data analyst positions offer impressive salary ranges, with the top role reaching a staggering $650,000.

- **SQL Dominates Top Jobs:** Advanced SQL skills are a common requirement in high-paying roles, reinforcing its importance for maximizing earnings.

- **Most In-Demand Skill:** SQL stands out as the most sought-after skill in the market, making it a must-have for aspiring analysts.

- **Niche Skills Pay More:** Specialized tools like SVN and Solidity are tied to higher average salaries, showing the value of mastering less common technologies.

- **Best Skill for Value:** With both high demand and strong salary potential, SQL remains the most strategic skill to boost job security and career growth in data analytics.
