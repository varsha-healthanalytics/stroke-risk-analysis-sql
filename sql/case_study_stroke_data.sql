/*==============================================================
                     STROKE RISK ANALYSIS
                 END-TO-END SQL CASE STUDY
===============================================================

Project: Stroke Risk Analysis Using SQL

Author: Varsha
Tool: MySQL Workbench
Database: MySQL
Dataset: Healthcare Stroke Prediction Dataset

===============================================================
PROJECT OVERVIEW
===============================================================

This project analyzes a healthcare dataset containing patient
demographic, lifestyle, and medical information to identify
patterns associated with stroke occurrence.

Using SQL, the project answers important business and healthcare
questions related to stroke prevalence, patient demographics,
hospital workload, and clinical risk factors.

The analysis demonstrates how SQL can be used to transform raw
healthcare data into meaningful insights that support preventive
healthcare strategies and data-driven decision-making.
*/

/*==============================================================
EXECUTIVE SUMMARY
===============================================================

This project analyzes a healthcare stroke dataset containing 5,110
patient records using MySQL. The objective was to identify patterns
associated with stroke prevalence and demonstrate SQL techniques for
healthcare data analysis.

The analysis revealed an overall stroke prevalence of 4.87%, with
stroke occurrence increasing substantially among older age groups.
Male patients showed a slightly higher stroke prevalence than female
patients, and stroke patients had an average blood glucose level of
132.54 mg/dL. A separate hospital operations section demonstrated SQL
joins, subqueries, CASE statements, and window functions using a
sample relational dataset.

Overall, the project demonstrates how SQL can be used to answer
business questions, generate actionable healthcare insights, and
support data-driven decision-making.
The project also investigates lifestyle-related risk factors, 
including smoking behavior and blood glucose levels, to identify 
high-risk patient cohorts for preventive healthcare.

*/

/*==============================================================
BUSINESS PROBLEM
===============================================================

Stroke is one of the leading causes of death and long-term
disability worldwide. Healthcare organizations need to identify
high-risk patient groups and understand the factors associated
with stroke occurrence.

This SQL project analyzes patient healthcare data to answer key
business questions related to stroke prevalence, demographic
patterns, and hospital-level insights.

Project Objectives

• Analyze overall stroke prevalence.
• Identify demographic patterns associated with stroke.
• Evaluate age- and gender-related stroke trends.
• Examine blood glucose levels among stroke patients.
• Analyze hospital-level patient distribution using relational SQL.
• Identify high-risk patient cohorts using lifestyle and clinical factors.
• Demonstrate advanced SQL techniques for healthcare analytics.

*/

/*==============================================================
DATABASE SETUP
===============================================================*/

CREATE DATABASE health_analysis;

USE health_analysis;

/*==============================================================
                PART 1: Population Health & Stroke Analysis
===============================================================

This section analyzes the Stroke Prediction dataset to explore
patient demographics and clinical characteristics associated with
stroke occurrence. The objective is to identify key trends in
stroke prevalence and demonstrate how SQL can be used to answer
real-world healthcare business questions.

The analyses include patient counts, stroke prevalence, demographic
comparisons, age-based risk analysis, and blood glucose evaluation
to support evidence-based healthcare decision-making.

Skills Demonstrated:
• SELECT Statements
• WHERE Clause
• Aggregate Functions (COUNT, AVG)
• GROUP BY
• ORDER BY
• CASE Statements
• Data Aggregation
• Business-Oriented Data Analysis
*/


/*==============================================================
ANALYSIS 1
TOTAL NUMBER OF PATIENTS
===============================================================

Business Question:
How many patient records are available for analysis?
*/

SELECT COUNT(*) AS total_patients
FROM stroke_data;

/*
Result:
Total Patients = 5,110

Insight:
The dataset contains 5,110 patient records, providing a sufficiently
large sample for analyzing stroke prevalence and identifying patterns
across demographic and clinical variables.

Recommendation:
Use this dataset as the baseline population for all subsequent analyses.
A dataset of this size supports reliable trend analysis and helps
generate meaningful healthcare insights for decision-making.
*/

/*==============================================================
ANALYSIS 2: TOTAL STROKE CASES
===============================================================

Business Question:
How many patients experienced a stroke?

*/

SELECT COUNT(*) AS total_stroke_cases
FROM stroke_data
WHERE stroke = 1;

/*
Result:
Total Stroke Cases = 249

Insight:
Out of 5,110 patient records, 249 patients experienced a stroke.
This indicates that stroke cases represent a relatively small but
clinically significant portion of the dataset, making it suitable for
identifying high-risk groups and understanding factors associated with
stroke occurrence.

Recommendation:
Healthcare providers should prioritize early screening and preventive
interventions for individuals with known stroke risk factors. Further
analysis of age, gender, and clinical indicators can help identify
populations requiring targeted preventive care.
*/

/*==============================================================
ANALYSIS 3: OVERALL STROKE PREVALENCE
===============================================================

Business Question:
What percentage of patients experienced a stroke?

*/

SELECT ROUND(AVG(stroke) * 100, 2) AS stroke_prevalence_percentage
FROM stroke_data;

/*
Result:
Overall Stroke Prevalence = 4.87%

Insight:
The analysis shows that 4.87% of patients in the dataset experienced
a stroke. Although the prevalence is relatively low, stroke remains
a critical health condition due to its high impact on mortality and
long-term disability. This highlights the importance of identifying
high-risk individuals before a stroke occurs.

Recommendation:
Healthcare organizations should strengthen preventive healthcare
programs by focusing on routine health screenings, lifestyle
modification, and early management of risk factors such as
hypertension, diabetes, and cardiovascular diseases. Even a small
reduction in stroke prevalence can significantly improve patient
outcomes and reduce healthcare costs.
*/
/*==============================================================
KEY FINDING 1
===============================================================

The dataset contains 5,110 patient records, of which 249 patients
experienced a stroke, resulting in an overall stroke prevalence of
4.87%. These baseline findings establish the foundation for further
analysis of demographic and clinical risk factors.
*/

/*==============================================================
ANALYSIS 4: STROKE Prevalence BY GENDER
===============================================================

Business Question:
Does stroke prevalence differ between male and female patients?

*/

SELECT
    gender,
    ROUND(AVG(stroke) * 100, 2) AS stroke_rate_percentage
FROM stroke_data
GROUP BY gender;

/*
Result:
Male   : 5.11%
Female : 4.71%
Other  : 0.00%

Insight:
Stroke prevalence is slightly higher among male patients (5.11%)
compared to female patients (4.71%) in this dataset. The difference
suggests a modest variation in stroke occurrence by gender. The
0.00% stroke Prevalence for the 'Other' category should be interpreted
with caution, as it is likely based on a very small number of records.

Recommendation:
Healthcare providers should continue promoting stroke awareness and
preventive screening for both male and female patients. Future studies
using larger and more balanced datasets could provide a clearer
understanding of gender-related differences in stroke risk.
*/

/*==============================================================
ANALYSIS 5: STROKE PREVALENCE BY AGE GROUP
===============================================================

Business Question:
Which age group has the highest stroke prevalence?

*/

SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        WHEN age BETWEEN 51 AND 70 THEN '51-70'
        ELSE 'Above 70'
    END AS age_group,
    ROUND(AVG(stroke) * 100, 2) AS stroke_prevalence_percentage
FROM stroke_data
GROUP BY
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        WHEN age BETWEEN 51 AND 70 THEN '51-70'
        ELSE 'Above 70'
    END
ORDER BY stroke_prevalence_percentage DESC;

/*
Result:
Above 70 : 18.03%
51-70    : 6.92%
30-50    : 1.43%
Under 30 : 0.13%

Insight:
Stroke prevalence increases substantially with age. Patients above
70 years have the highest stroke prevalence (18.03%), followed by
those aged 51-70 (6.92%). In contrast, patients under 30 show a
very low prevalence (0.13%). These findings suggest that advancing
age is strongly associated with an increased likelihood of stroke.

Recommendation:
Healthcare organizations should prioritize regular health screenings,
blood pressure monitoring, diabetes management, and lifestyle
interventions for older adults, particularly those aged 51 years
and above. Early identification and management of risk factors can
help reduce stroke incidence in high-risk populations.
*/
/*==============================================================
KEY FINDING 2
===============================================================

Stroke prevalence increases significantly with age. While patients
under 30 have a stroke prevalence of only 0.13%, the prevalence
rises to 18.03% among patients above 70 years. This indicates that
age is one of the strongest factors associated with stroke in the
dataset and should be a key consideration in preventive healthcare
strategies.
*/

/*==============================================================
ANALYSIS 6: AVERAGE GLUCOSE LEVEL AMONG STROKE PATIENTS
===============================================================

Business Question:
What is the average blood glucose level among patients who experienced
a stroke?

*/

SELECT
    ROUND(AVG(avg_glucose_level), 2) AS average_glucose_level
FROM stroke_data
WHERE stroke = 1;

/*
Result:
Average Blood Glucose Level (Stroke Patients) = 132.54 mg/dL

Insight:
Patients who experienced a stroke had an average blood glucose level
of 132.54 mg/dL. This value is higher than the normal fasting blood
glucose range, suggesting that elevated glucose levels may be associated
with an increased risk of stroke in the dataset. While this analysis
does not establish causation, it highlights blood glucose as an important
clinical indicator to monitor.

Recommendation:
Healthcare providers should encourage regular blood glucose screening,
especially among individuals with diabetes or other cardiovascular risk
factors. Early detection and effective glucose management may help
reduce the risk of stroke and improve long-term patient outcomes.
*/
/*==============================================================
KEY FINDING 3
===============================================================

The analysis indicates that stroke patients have an average blood
glucose level of 132.54 mg/dL. Combined with the age-group analysis,
the findings suggest that older adults with elevated blood glucose
levels represent an important population for preventive healthcare
interventions and routine clinical monitoring.
*/



/*==============================================================
                 PART 2: Hospital Operations & SQL Techniques
===============================================================

This section demonstrates SQL joins and relational database concepts
using the Patients and Hospital tables. The analysis focuses on
hospital-level patient distribution, stroke burden, and demographic
patterns to support operational and resource planning.

Skills Demonstrated:
• INNER JOIN
• LEFT JOIN
• Aggregate Functions
• GROUP BY
• CASE WHEN
• HAVING
• Subqueries
• Window Functions
*/

/*
Note:
The Patients and Hospital tables are sample datasets created to
demonstrate SQL concepts such as JOINs, aggregate functions,
subqueries, and window functions. The analyses in this section are
intended to showcase SQL techniques rather than derive real-world
healthcare conclusions.
*/

/*==============================================================
ANALYSIS 7: PATIENT AND HOSPITAL DETAILS
===============================================================

Business Question:
Which hospital is each patient associated with?

*/

SELECT
    p.patient_id,
    p.age,
    h.hospital_name,
    h.city
FROM patients p
INNER JOIN hospital h
ON p.hospital_id = h.hospital_id;

/*
Result:
5 patient records were successfully matched with their respective
hospital names and cities using an INNER JOIN.

Hospital Distribution:
• AIIMS (Delhi)      : 2 Patients
• Apollo (Mumbai)    : 2 Patients
• Fortis (Bangalore) : 1 Patient

Insight:
The INNER JOIN successfully combines patient and hospital information,
providing a unified view of patient demographics and hospital details.
This type of analysis is essential for hospital reporting, patient
tracking, and operational decision-making.

Recommendation:
Healthcare organizations should maintain accurate relationships between
patient and hospital records to support efficient reporting, resource
allocation, and patient management. Relational database design enables
quick access to integrated information across multiple tables.
*/


/*==============================================================
ANALYSIS 8: HOSPITAL-WISE STROKE ANALYSIS
===============================================================

Business Question:
How are patients and stroke cases distributed across hospitals?

*/

SELECT
    h.hospital_name,
    COUNT(*) AS total_patients,
    SUM(p.stroke) AS total_stroke_cases,
    ROUND(AVG(p.stroke) * 100, 2) AS stroke_prevalence_percentage
FROM patients p
INNER JOIN hospital h
ON p.hospital_id = h.hospital_id
GROUP BY h.hospital_name;

/*
Result:

Hospital Name | Total Patients | Total Stroke Cases | Stroke Prevalence
-----------------------------------------------------------------------
AIIMS         |       2        |         2          |      100.00%
Apollo        |       2        |         1          |       50.00%
Fortis        |       1        |         0          |        0.00%

Insight:
The sample data shows variation in stroke prevalence across hospitals.
AIIMS recorded the highest stroke prevalence (100%), followed by Apollo
(50%), while no stroke cases were observed at Fortis. These differences
reflect the distribution of the small sample dataset and demonstrate how
SQL can be used to compare hospital-level performance and patient outcomes.

Recommendation:
Hospital-level analysis can help healthcare administrators identify
facilities with higher disease burden and support resource planning.
In real-world healthcare settings, such analyses should be performed
using larger datasets before drawing operational or clinical conclusions.
*/

/*==============================================================
KEY FINDING 4
===============================================================

Hospital-level analysis demonstrates how SQL joins and aggregate
functions can be used to compare patient distribution and stroke
prevalence across healthcare facilities. Although this section uses
a small sample dataset for demonstration purposes, the same approach
can be applied to large hospital databases to support operational
planning and performance monitoring.
*/

/*==============================================================
ANALYSIS 9: PATIENTS ABOVE 50 YEARS BY HOSPITAL
===============================================================

Business Question:
Which hospitals are treating patients above 50 years of age?

*/

SELECT
    h.hospital_name,
    h.city,
    p.patient_id,
    p.age,
    p.stroke
FROM patients p
INNER JOIN hospital h
ON p.hospital_id = h.hospital_id
WHERE p.age > 50
ORDER BY p.age DESC;

/*
Result:

Hospital Name | City    | Patient ID | Age | Stroke
----------------------------------------------------
Apollo        | Mumbai  | 105        | 80  | 1
AIIMS         | Delhi   | 103        | 70  | 1
AIIMS         | Delhi   | 101        | 65  | 1

Insight:
The sample dataset shows that all patients above 50 years of age who
were identified in this analysis had experienced a stroke. AIIMS treated
two patients above 50 years, while Apollo treated one patient. This
illustrates how SQL can be used to identify elderly patients who may
require closer clinical monitoring and follow-up.

Recommendation:
Healthcare providers should prioritize regular health assessments and
stroke risk screening for older adults, particularly those above
50 years of age. Hospital-level reporting of elderly patients can
support preventive care planning, resource allocation, and targeted
health interventions. Since this analysis uses a small demonstration
dataset, broader conclusions should be validated using larger datasets.
*/
/*==============================================================
KEY FINDING 5
===============================================================

The hospital-level analysis demonstrates that SQL joins can be used to
identify high-risk patient groups across healthcare facilities. In this
sample dataset, all patients above 50 years identified in the analysis
had experienced a stroke, emphasizing the importance of age-based
screening and preventive healthcare initiatives.
*/

/*==============================================================
ANALYSIS 10: BMI CATEGORY CLASSIFICATION
===============================================================

Business Question:
How can patients be classified into BMI categories based on
their Body Mass Index (BMI)?

*/

SELECT
    patient_id,
    bmi,
    CASE
        WHEN bmi >= 30 THEN 'Obese'
        WHEN bmi >= 25 THEN 'Overweight'
        ELSE 'Normal'
    END AS bmi_category
FROM patients
ORDER BY bmi DESC;

/*
Result:

Patient ID | BMI  | BMI Category
--------------------------------
103        | 30.1 | Obese
105        | 29.4 | Overweight
101        | 28.5 | Overweight
104        | 26.3 | Overweight
102        | 24.2 | Normal

Insight:
Patients were successfully classified into BMI categories using a
CASE statement. Among the five patients, one patient was classified
as Obese, three as Overweight, and one as Normal. This demonstrates
how SQL can be used to convert continuous numerical values into
clinically meaningful categories for analysis and reporting.

Recommendation:
BMI classification can help healthcare professionals identify patients
who may benefit from lifestyle interventions such as nutrition
counseling, physical activity programs, and routine health monitoring.
In larger healthcare datasets, BMI categorization can be combined with
other clinical variables to identify populations at increased risk of
chronic diseases, including stroke.
*/
/*==============================================================
KEY FINDING 6
===============================================================

Using SQL CASE statements, patients were categorized into BMI groups.
Most patients in the sample dataset were classified as Overweight or
Obese, demonstrating how SQL can transform raw clinical measurements
into meaningful categories for healthcare reporting and risk
stratification.
*/

/*==============================================================
ANALYSIS 11: PATIENTS OLDER THAN THE AVERAGE AGE
===============================================================

Business Question:
Which patients are older than the average age of all patients?

*/

SELECT
    patient_id,
    age,
    gender,
    bmi,
    stroke
FROM patients
WHERE age >
(
    SELECT AVG(age)
    FROM patients
)
ORDER BY age DESC;

/*
Result:

Patient ID | Age | Gender | BMI  | Stroke
------------------------------------------
105        | 80  | Male   | 29.4 | 1
103        | 70  | Male   | 30.1 | 1
101        | 65  | Male   | 28.5 | 1

Insight:
The average age of patients in the sample dataset is 62 years. Using
a subquery, three patients were identified as being older than the
average age. All three patients had experienced a stroke, illustrating
how subqueries can be used to identify patient groups that meet dynamic
conditions based on calculated values.

Recommendation:
Subqueries are valuable for identifying patients who may require
additional monitoring based on calculated benchmarks, such as average
age or BMI. In larger healthcare databases, this technique can support
risk stratification and targeted preventive care for higher-risk
patient groups.
*/
/*==============================================================
KEY FINDING 7
===============================================================

Subqueries enable dynamic filtering by comparing individual records
against calculated values. In this sample dataset, all patients older
than the average age had experienced a stroke, demonstrating how SQL
can be used to identify potentially high-risk patient groups for
further analysis.
*/

/*==============================================================
ANALYSIS 12: PATIENT AGE RANKING
===============================================================

Business Question:
How can patients be ranked based on their age?

*/

SELECT
    patient_id,
    age,
    RANK() OVER (ORDER BY age DESC) AS age_rank
FROM patients;

/*
Result:

Patient ID | Age | Age Rank
----------------------------
105        | 80  | 1
103        | 70  | 2
101        | 65  | 3
104        | 50  | 4
102        | 45  | 5

Insight:
Patients were ranked from oldest to youngest using the SQL RANK()
window function. Patient 105 (80 years) received the highest rank,
followed by patients aged 70 and 65 years. Window functions allow
analysts to rank records without grouping the data, making them
valuable for identifying priority cases and performing comparative
analysis.

Recommendation:
Window functions can support healthcare reporting by identifying
high-priority patient groups based on age, risk scores, or clinical
measurements. In larger healthcare databases, ranking techniques can
assist clinicians and administrators in prioritizing patient care and
resource allocation.
*/
/*==============================================================
KEY FINDING 8
===============================================================

The project demonstrates SQL techniques ranging from basic data
retrieval to advanced analytical functions. Aggregate functions,
conditional logic, joins, subqueries, and window functions were
used to transform healthcare data into meaningful business insights,
illustrating the value of SQL in healthcare analytics.
*/

/*==============================================================
             PART 3: ADVANCED SQL ANALYTICS
===============================================================

This section applies advanced SQL techniques to support more
complex healthcare analytics and reporting scenarios. The analyses
demonstrate how SQL can be used to identify priority patient groups,
summarize healthcare information, and answer analytical questions
that support data-driven clinical and operational decision-making.

These techniques improve query readability, simplify complex logic,
and enable scalable analysis for larger healthcare databases.

Skills Demonstrated:
• DISTINCT
• MIN & MAX
• LIMIT
• HAVING
• Common Table Expressions (CTEs)
• Correlated Subqueries
*/

/*==============================================================
ANALYSIS 13: YOUNGEST AND OLDEST PATIENT
===============================================================

Business Question:
What are the minimum and maximum patient ages?

*/

SELECT
MIN(age) AS youngest_patient,
MAX(age) AS oldest_patient
FROM stroke_data;

/*
Result:

Youngest Patient : 0 Years
Oldest Patient   : 82 Years

Insight:
The patient ages in the dataset range from 0 to 82 years,
indicating that the dataset includes individuals across the
entire lifespan, from infants to older adults. This broad age
distribution enables comprehensive analysis of stroke prevalence
across different age groups and supports age-based risk assessment.

Business Value:
Understanding the age range of the patient population helps
healthcare organizations design age-specific health programs,
allocate preventive resources, and ensure analyses accurately
represent the entire target population.

*/

/*==============================================================
ANALYSIS 14: TOP 5 OLDEST PATIENTS
===============================================================

Business Question:
What are the characteristics of the five oldest patient records?

*/

SELECT
age,
gender,
avg_glucose_level,
stroke
FROM stroke_data
ORDER BY age DESC
LIMIT 5;

/*
Result:

The five oldest patient records in the dataset are all 82 years old.
Among these five patients:
• 2 patients experienced a stroke.
• 3 patients did not experience a stroke.

Insight:
The query identified the five oldest patient records using ORDER BY
and LIMIT. While all five patients belong to the oldest age group,
their stroke outcomes differ, indicating that advanced age alone
does not determine stroke occurrence. This reinforces the importance
of evaluating multiple clinical and lifestyle factors when assessing
stroke risk.

Business Value:
Retrieving the oldest patient records enables healthcare analysts to
quickly identify high-priority populations for further investigation.
In real-world healthcare settings, similar queries can support
geriatric health reporting, clinical audits, and targeted analyses of
elderly patient outcomes.
*/

/*==============================================================
ANALYSIS 15: UNIQUE GENDER CATEGORIES
===============================================================

Business Question:
What unique gender categories are represented in the patient population?

*/

SELECT DISTINCT gender
FROM stroke_data;

/*
Result:

The dataset contains three gender categories:
• Male
• Female
• Other

Insight:
The DISTINCT keyword was used to identify the unique gender categories
present in the dataset. Understanding the available demographic
categories is an important first step in data exploration, ensuring
that subsequent analyses, such as stroke prevalence by gender, are
performed using complete and accurate population groups.

Business Value:
Identifying unique categorical values supports data quality assessment
and validates the dimensions available for demographic analysis. This
helps healthcare analysts build accurate reports, dashboards, and
segmented analyses for evidence-based decision-making.
*/

/*==============================================================
ANALYSIS 16: HOSPITALS WITH MORE THAN ONE PATIENT
===============================================================

Business Question:
Which hospitals have treated more than one patient?

*/

SELECT
h.hospital_name,
COUNT(*) AS total_patients
FROM patients p
INNER JOIN hospital h
ON p.hospital_id=h.hospital_id
GROUP BY h.hospital_name
HAVING COUNT(*)>1;

/*
Result:

Hospital Name | Total Patients
-------------------------------
AIIMS         | 2
Apollo        | 2

Insight:
The analysis identified hospitals with more than one patient record
using the HAVING clause after grouping the data. Among the sample
hospital dataset, AIIMS and Apollo each treated two patients,
while Fortis was excluded because it did not satisfy the specified
condition.

Business Value:
The HAVING clause enables analysts to filter aggregated results,
making it easier to identify hospitals, departments, or healthcare
facilities that meet specific reporting thresholds. In real-world
healthcare analytics, this technique supports operational reporting,
resource planning, workload analysis, and performance monitoring by
focusing attention on groups that satisfy defined business criteria.
*/

/*==============================================================
ANALYSIS 17: HIGH-RISK PATIENTS USING CTE
===============================================================

Business Question:
Which high-risk patients meet the defined clinical criteria, and which
hospitals are providing their care?

*/

WITH high_risk_patients AS
(
    SELECT
        p.patient_id,
        p.age,
        p.gender,
        p.stroke,
        h.hospital_name
    FROM patients p
    INNER JOIN hospital h
        ON p.hospital_id = h.hospital_id
    WHERE p.age > 60
      AND p.stroke = 1
)

SELECT *
FROM high_risk_patients;

/*
Result:

Patient ID | Age | Gender | Stroke | Hospital Name
--------------------------------------------------
103        | 70  | Male   | 1      | AIIMS
101        | 65  | Male   | 1      | AIIMS
105        | 80  | Male   | 1      | Apollo

Insight:
A Common Table Expression (CTE) was used to create a high-risk patient
cohort based on predefined criteria (age above 60 years and a history
of stroke). By integrating hospital information through an INNER JOIN,
the analysis identified three high-risk patients receiving care across
two hospitals. This approach demonstrates how multiple SQL techniques
can be combined to produce meaningful clinical reports.

Business Value:
CTEs improve the readability and maintainability of complex SQL queries
by organizing analytical logic into reusable components. In healthcare
analytics, cohort-based analyses help hospitals identify patients who
require priority monitoring, evaluate the distribution of high-risk
patients across healthcare facilities, and support targeted clinical
interventions and resource planning.
*/

/*==============================================================
ANALYSIS 18: IDENTIFYING PATIENTS ABOVE THEIR HOSPITAL'S
AVERAGE AGE USING A CORRELATED SUBQUERY
===============================================================

Business Question:
Which patients are older than the average age of patients treated
at the same hospital?

*/

SELECT
    p1.patient_id,
    p1.age,
    h.hospital_name
FROM patients p1
INNER JOIN hospital h
ON p1.hospital_id = h.hospital_id
WHERE p1.age >
(
    SELECT AVG(p2.age)
    FROM patients p2
    WHERE p1.hospital_id = p2.hospital_id
)
ORDER BY h.hospital_name, p1.age DESC;

/*
Result:

Patient ID | Age | Hospital Name
--------------------------------
103        | 70  | AIIMS
105        | 80  | Apollo

Insight:
A correlated subquery was used to compare each patient's age with
the average age of patients treated at the same hospital. This
analysis identified patients whose age is above their hospital's
average, enabling comparisons within individual healthcare
facilities rather than across the entire dataset.

Business Value:
Correlated subqueries support more granular healthcare analysis by
evaluating patients within the context of their own hospital or
clinical group. This approach helps healthcare organizations
identify patient cohorts requiring additional attention, supports
hospital-level benchmarking, and enables more targeted operational
and clinical decision-making.
*/

/*==============================================================
PART 3 SUMMARY
===============================================================

Part 3 demonstrated advanced SQL analytical techniques used to
solve more complex healthcare reporting problems. By applying
aggregate functions, DISTINCT, HAVING, Common Table Expressions
(CTEs), and correlated subqueries, the analysis illustrated how
SQL can efficiently identify meaningful patient cohorts, simplify
complex query logic, and support data-driven healthcare decision-
making.

These techniques are widely used in healthcare analytics,
business intelligence, and health informatics to generate
scalable, maintainable, and actionable insights from relational
databases.
*/

/*==============================================================
         PART 4: LIFESTYLE RISK FACTORS & STROKE ANALYSIS
===============================================================

This section investigates the relationship between smoking behavior
and stroke-related health outcomes. By analyzing smoking status
alongside demographic and clinical indicators, the analyses identify
high-risk patient groups and provide insights that support preventive
healthcare strategies and evidence-based decision-making.

The analyses demonstrate how SQL can be applied to evaluate lifestyle
risk factors, compare health outcomes across patient groups, and
generate actionable insights for population health management.

Skills Demonstrated:
• Aggregate Functions
• GROUP BY
• ORDER BY
• Multiple Filtering Conditions
• Correlated Subqueries
• Healthcare Risk Analysis
*/
/*==============================================================
ANALYSIS 19: STROKE PREVALENCE BY SMOKING STATUS
===============================================================

Business Question:
How does stroke prevalence differ across smoking status categories,
and which patient groups should be prioritized for preventive
healthcare interventions?

*/

SELECT
    smoking_status,
    COUNT(*) AS total_patients,
    SUM(stroke) AS total_stroke_cases,
    ROUND(AVG(stroke) * 100,2) AS stroke_prevalence_percentage
FROM stroke_data
GROUP BY smoking_status
ORDER BY stroke_prevalence_percentage DESC;

/*
Result:

Smoking Status | Total Patients | Total Stroke Cases | Stroke Prevalence
-----------------------------------------------------------------------
Formerly Smoked |      885       |         70         |      7.91%
Smokes          |      789       |         42         |      5.32%
Never Smoked    |     1892       |         90         |      4.76%
Unknown         |     1544       |         47         |      3.04%

Insight:
Stroke prevalence varies across smoking status categories. Patients
who formerly smoked have the highest stroke prevalence (7.91%),
followed by current smokers (5.32%). Patients who never smoked
show a lower prevalence (4.76%), while the 'Unknown' category
records the lowest prevalence (3.04%). These findings suggest an
association between smoking history and stroke occurrence within
the dataset. However, the analysis is descriptive and should not
be interpreted as establishing a causal relationship.

Business Value:
Analyzing stroke prevalence by smoking status enables healthcare
organizations to identify lifestyle-related risk patterns within
the patient population. These insights can support targeted
awareness campaigns, smoking cessation initiatives, preventive
screening programs, and risk stratification strategies for
individuals with a history of smoking.
*/

/*==============================================================
ANALYSIS 20: IDENTIFYING HIGH-RISK PATIENTS FOR TARGETED
STROKE PREVENTION
===============================================================

Business Question:
Which patient cohort should be prioritized for targeted stroke
prevention based on smoking behavior, age, and clinical risk
factors?

*/

SELECT
    age,
    gender,
    smoking_status,
    hypertension,
    work_type,
    ROUND(avg_glucose_level,2) AS avg_glucose_level,
    ROUND(bmi,1) AS bmi
FROM stroke_data
WHERE smoking_status = 'smokes'
AND age > 60
AND stroke = 1
AND hypertension = 1
AND bmi >= 25
ORDER BY
    avg_glucose_level DESC,
    age DESC;
    
    /*
Result:

The query returned all patient records meeting the defined 
high-risk criteria:

• Current smoker
• Age greater than 60 years
• History of stroke
• Hypertension
• BMI classified as Overweight or Obese (BMI ≥ 25)

The result includes demographic information (age and gender),
clinical indicators (hypertension, average glucose level, BMI),
and employment type. The records are ordered by average blood
glucose level in descending order to highlight patients with the
greatest metabolic risk.

Insight:
The identified cohort consists of older adults who currently smoke
and have experienced a stroke. Many patients also exhibit additional
risk factors, including hypertension, elevated blood glucose levels,
and higher BMI values. Combining multiple clinical and lifestyle
variables provides a more comprehensive assessment of patient risk
than evaluating a single factor in isolation.

Business Value:
Identifying high-risk patient cohorts enables healthcare providers
to prioritize preventive interventions, optimize resource allocation,
and support personalized care planning. Multi-factor cohort analysis
can assist clinicians in developing targeted disease management
programs, strengthen smoking cessation initiatives, and improve
population health management by focusing on patients with multiple
modifiable risk factors.
*/

/*==============================================================
ANALYSIS 21: IDENTIFYING PATIENTS WITH ABOVE-AVERAGE BLOOD GLUCOSE
WITHIN EACH SMOKING STATUS USING A CORRELATED SUBQUERY
===============================================================

Business Question:
Which patients have blood glucose levels above the average for
their respective smoking status group?

*/

SELECT
    s1.age,
    s1.gender,
    s1.smoking_status,
    s1.hypertension,
    ROUND(s1.avg_glucose_level,2) AS avg_glucose_level,
    ROUND(s1.bmi,1) AS bmi
FROM stroke_data s1
WHERE s1.avg_glucose_level >
(
    SELECT AVG(s2.avg_glucose_level)
    FROM stroke_data s2
    WHERE s1.smoking_status = s2.smoking_status
)
ORDER BY
    s1.smoking_status,
    avg_glucose_level DESC;
    
/*
Result:

The query identified all patients whose blood glucose levels are
higher than the average glucose level within their respective
smoking status category.

The output includes demographic information (age and gender),
together with clinical indicators (hypertension, blood glucose
level, and BMI), enabling comparison of patients with relatively
higher metabolic risk within each smoking status group.

Note:
MySQL Workbench is configured to display a maximum of 1000 rows in the result grid by default.
 The query returns all qualifying records that satisfy the defined condition.

Insight:

Using a correlated subquery, the analysis compares each patient's
blood glucose level with the average glucose level of patients
sharing the same smoking status. This approach highlights
individuals with comparatively elevated glucose levels within
their peer group, enabling more meaningful comparisons than using
an overall population average.

Business Value:

Comparing patients against the average of their own smoking status
group provides more meaningful insights than comparing them with
the overall population average. This analysis supports risk
stratification, targeted screening, and personalized healthcare
interventions by identifying individuals with relatively elevated
metabolic risk within each lifestyle group. Such insights can help
healthcare providers prioritize follow-up assessments and
preventive care programs.
*/

/*==============================================================
OVERALL KEY FINDINGS
===============================================================

1. The dataset contains 5,110 patient records, including 249
   confirmed stroke cases.

2. The overall stroke prevalence was 4.87%, indicating that stroke
   cases represent a relatively small but clinically significant
   proportion of the patient population.

3. Stroke prevalence increased substantially with age, reaching
   18.03% among patients aged above 70 years, highlighting age as
   an important risk factor.

4. Male patients exhibited a slightly higher stroke prevalence
   (5.11%) compared to female patients (4.71%).

5. Patients with stroke had an average blood glucose level of
   132.54 mg/dL, suggesting an association between elevated blood
   glucose levels and stroke occurrence.

6. Patients with a history of smoking, particularly former smokers,
   demonstrated higher stroke prevalence than other smoking status
   groups, emphasizing the importance of lifestyle-related risk
   factors.

7. High-risk patient cohorts were successfully identified by
   combining demographic, lifestyle, and clinical variables such
   as age, smoking status, hypertension, BMI, and blood glucose
   levels.

8. Relational database techniques, including SQL joins, enabled
   integration of patient and hospital information to support
   operational reporting and healthcare resource planning.

9. Advanced SQL techniques, including CASE statements, Common
   Table Expressions (CTEs), correlated subqueries, aggregate
   functions, HAVING clauses, and window functions, were applied
   to answer business-focused healthcare questions and generate
   actionable insights.
*/

/*==============================================================
BUSINESS RECOMMENDATIONS
===============================================================

1. Prioritize preventive stroke screening programs for adults aged
   50 years and above, particularly individuals over 70 years,
   where stroke prevalence was highest.

2. Strengthen routine monitoring of blood glucose levels to support
   early identification of patients at increased risk of stroke.

3. Expand smoking cessation and lifestyle modification programs,
   focusing on individuals with a current or previous history of
   smoking to reduce modifiable stroke risk factors.

4. Implement multi-factor risk assessment by combining age,
   hypertension, BMI, blood glucose level, and smoking history to
   improve patient risk stratification and personalized preventive
   care.

5. Utilize hospital-level reporting and SQL-based dashboards to
   monitor patient distribution, stroke burden, and healthcare
   resource utilization across facilities.

6. Integrate automated SQL reporting into healthcare information
   systems to support timely clinical decision-making and
   population health management.

7. Continue enhancing healthcare analytics by incorporating
   additional clinical variables, longitudinal patient records,
   treatment outcomes, and predictive modeling techniques to
   support more comprehensive risk assessment.
*/

/*==============================================================
PROJECT LIMITATIONS
===============================================================

1. The dataset represents observational patient data and should
   not be used to establish causal relationships between risk
   factors and stroke occurrence.

2. Some variables, including smoking status, contain an "Unknown"
   category, which may affect the interpretation of lifestyle-
   related analyses.

3. The hospital analysis uses a small demonstration dataset
   created to illustrate SQL joins and relational database
   concepts and does not represent real hospital operations.

4. The dataset does not include longitudinal patient follow-up,
   treatment history, medication information, or clinical outcomes,
   limiting the scope of advanced healthcare analysis.

5. Future studies could incorporate larger real-world healthcare
   datasets and predictive machine learning models to improve
   stroke risk prediction and clinical decision support.
*/

/*==============================================================
PROJECT CONCLUSION
===============================================================

This project demonstrates the practical application of SQL in
healthcare analytics by transforming raw patient data into
meaningful business insights. Using filtering, aggregation,
conditional logic, joins, Common Table Expressions (CTEs),
correlated subqueries, window functions, and other advanced SQL
techniques, the project explored demographic, clinical, lifestyle,
and operational factors associated with stroke prevalence.

The analyses identified high-risk patient groups, evaluated
lifestyle-related risk factors such as smoking, examined hospital-
level patient information, and generated actionable insights to
support preventive healthcare strategies and informed decision-
making.

Beyond demonstrating SQL proficiency, this project highlights the
ability to translate analytical results into business-focused
recommendations for healthcare organizations. The skills applied
throughout this case study—including data exploration, business
problem solving, and healthcare data interpretation—are directly
relevant to roles in Healthcare Data Analytics, Business
Intelligence, and Health Informatics.
*/






