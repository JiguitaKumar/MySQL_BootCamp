#Window Functions
CREATE TABLE employees (
	emp_no INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

SELECT * FROM employees;
SELECT department, AVG(salary) FROM employees GROUP BY department WITH ROLLUP;


-- OVER
SELECT emp_no, department, salary, AVG(salary) OVER() FROM employees;
SELECT emp_no, department, salary, MIN(salary) OVER(), MAX(salary) OVER() FROM employees;


-- PARTITION BY
SELECT 
	emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS department_avg,
    AVG(salary) OVER() AS company_avg
FROM employees;

SELECT
	emp_no,
    department,
    COUNT(*) OVER(PARTITION BY department) AS dpt_employees,
    COUNT(*) OVER() AS company_employees
FROM employees;

SELECT
	emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department) AS dpt_payroll,
    SUM(salary) OVER() AS total_payroll
FROM employees;


-- ORDER BY
SELECT 
	emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department) AS dpt_salary,
    SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_dpt_salary
FROM employees;

SELECT
	emp_no,
    department,
    salary,
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_min
FROM employees;


-- RANK
SELECT 
	emp_no,
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) as overall_salary_rank
FROM employees;

SELECT 
	emp_no,
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as dpt_salary_rank
FROM employees;


-- ROW_NUMBER
SELECT 
	emp_no,
    department,
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as dpt_row_number
FROM employees;


-- DENSE_RANK
SELECT 
	emp_no,
    department,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) as salary_dense_rank
FROM employees;


-- NTILE
SELECT
	emp_no,
    department,
    salary,
     NTILE(4) OVER(PARTITION BY	department ORDER BY salary DESC) AS dpt_salary_quartile,
    NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees 
ORDER BY department;


-- FIRST_VALUE
SELECT 
	emp_no,
    department,
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) AS highest_paid_dept,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) AS highest_paid
FROM employees;


-- LEAD & LAG
SELECT 
	emp_no,
    department,
    salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC) as salary_diff
FROM employees;

SELECT 
	emp_no,
    department,
    salary,
    salary - LEAD(salary) OVER(ORDER BY salary DESC) as salary_diff
FROM employees;

SELECT 
	emp_no,
    department,
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as salary_diff
FROM employees;

SELECT 
	emp_no,
    department,
    salary,
    salary - LAG(salary, 2) OVER(PARTITION BY department ORDER BY salary DESC) as salary_diff
FROM employees;