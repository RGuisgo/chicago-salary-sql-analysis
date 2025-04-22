SELECT * 
FROM salary.salary_stagging;

ALTER TABLE  salary.salary_stagging
RENAME COLUMN `ï»¿Name` TO `Name`;


# selecting the second highest slalry


SELECT Department, Name, `Annual Salary`
FROM (
    SELECT 
        Department, 
        Name, 
        `Annual Salary`,
        ROW_NUMBER() OVER (PARTITION BY Department ORDER BY `Annual Salary` DESC) AS salary_rank
    FROM salary.salary_stagging
) ranked_salaries
WHERE salary_rank = 2;


-- List the first 10 rows of the dataset.

SELECT *
FROM salary.salary_stagging
LIMIT 10;

-- Find all unique departments in the dataset.

SELECT distinct Department
FROM salary.salary_stagging;

--  Count how many employees work in each department.

SELECT Department, COUNT(Name) As Number_of_employees
FROM salary.salary_stagging
GROUP BY Department
;

-- What is the average annual salary across all employees?

SELECT AVG(`Annual Salary`) As average_salary_of_employees
FROM salary.salary_stagging
;

-- List all employees who earn more than $20,000 annually.

SELECT Name, `Annual Salary`
FROM salary.salary_stagging
WHERE `Annual Salary` > 20000
;

-- Which department has the highest average salary?

SELECT Department, AVG(`Annual Salary`) AS average_salary
FROM salary.salary_stagging
GROUP BY Department
ORDER BY average_salary DESC
;

-- Find the top 5 highest-paid employees.

SELECT Name, `Annual Salary`
FROM salary.salary_stagging
ORDER BY `Annual Salary` DESC
LIMIT 5
;

-- Show the number of employees earning below the average salary.

SELECT Department, Count(`Annual Salary`)
FROM salary.salary_stagging
WHERE `Annual Salary` < (SELECT AVG(`Annual Salary`)
FROM salary.salary_stagging)
GROUP BY Department
;

-- List employees whose names start with 'A' and earn more than $10,000.

SELECT Name 
FROM salary.salary_stagging
WHERE NAME LIKE 'A%' AND
 `Annual Salary` > 10000;


-- Which departments have more than 30 employees?

SELECT count(f.Department), s.Department
From  salary.salary_stagging f
JOIN salary.salary_stagging s 
ON f.Name = s.Name
GROUP BY s.Department
HAVING count(s.Department) >30 ;

-- OR 

SELECT Department, COUNT(*) AS num_employees
FROM salary.salary_stagging
GROUP BY Department
HAVING COUNT(*) > 30;

-- Find the employee(s) earning the second-highest salary in each department

SELECT Name, Department, `Annual Salary`
FROM (SELECT Name, Department, `Annual Salary`,
ROW_NUMBER() OVER(PARTITION BY DEPARTMENT ORDER BY `Annual Salary` DESC) AS ranked
FROM salary.salary_stagging) AS sq
WHERE ranked =2 ;

-- Which department has the biggest salary range (max - min salary)?

SELECT Department
FROM (SELECT  Department,
ROW_NUMBER() OVER(ORDER BY MAX(`Annual Salary`) - MIN(`Annual Salary`) DESC) AS ranked
FROM salary.salary_stagging
GROUP BY Department) AS sq
WHERE ranked =1 ;

-- Rank employees by salary within their department.

SELECT Department, Name,`ANNUAL Salary`,
RANK() OVER(PARTITION BY Department ORDER BY `Annual Salary` DESC) AS ranked
FROM salary.salary_stagging ;

