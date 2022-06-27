CREATE TABLE project1."data_science_team"(EMP_ID varchar(100) ,FIRST_NAME varchar(100) ,
			LAST_NAME varchar(100), GENDER varchar(100), ROLE varchar(100) ,
			DEPT varchar(100) , EXP varchar(100) , COUNTRY varchar(100) , CONTINENT varchar(100))
			
SELECT * FROM project1.data_science_team

CREATE TABLE project1."emp_record_table"(EMP_ID varchar(100) ,FIRST_NAME varchar(100) ,
				LAST_NAME varchar(100), GENDER varchar(100), ROLE varchar(100) , DEPT varchar(100) , 
			EXP varchar(100) , COUNTRY varchar(100) , CONTINENT varchar(100), SALARY varchar(100), 
				EMP_RATING varchar(100), MANAGER_ID varchar(100), PROJ_ID varchar(100))
SELECT * FROM project1.emp_record_table	


CREATE TABLE project1."project_table"(PROJECT_ID varchar(100), PROJ_NAME varchar(100), 
			DOMAIN varchar(100), START_DATE varchar(100), CLOSURE_DATE  varchar(100), DEV_QTR varchar(100),
				STATUS varchar(100))
SELECT * FROM project1.project_table


--Query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
SELECT emp_id,
       first_name,
	   last_name,
	   gender,
	   dept
FROM project1.emp_record_table

--Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is:
--less than two
SELECT emp_id,
       first_name,
	   last_name,
	   gender,
	   dept,
	   emp_rating<'2' AS emp_rating_less_than_2
FROM project1.emp_record_table


--Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is:
--greater than four

SELECT emp_id,
       first_name,
	   last_name,
	   gender,
	   dept,
	   emp_rating>'4' AS emp_rating_more_than_4
FROM simplilearn_project_1."emp_record_table"

--Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is:
--between two and four
SELECT emp_id,
       first_name,
	   last_name,
	   gender,
	   dept,
	   emp_rating>'2' AND emp_rating<'4' AS emp_rating_between_2_and_4
FROM simplilearn_project_1."emp_record_table"
--query to concatenate the FIRST_NAME and the LAST_NAME of employees
--in the Finance department from the employee table and then give the resultant column alias as NAME.
SELECT first_name,
	   last_name,
	   dept,
	   first_name || ', ' || last_name AS NAME
FROM simplilearn_project_1."emp_record_table"
WHERE dept = FINANCE
--query to list only those employees who have someone reporting to them.
--Also, show the number of reporters (including the President).