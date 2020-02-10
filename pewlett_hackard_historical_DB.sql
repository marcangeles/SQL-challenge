-- Pewlett Hackard Historical Employee Database --
-- Analysis Performed By: Martin Santos 10/10/2019 --


-- Create and establish tables for .csv import --

CREATE TABLE employees (
    emp_no INT NOT NULL,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(255) NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(255) NOT NULL,
    hire_date   DATE NOT NULL,
    PRIMARY KEY (emp_no)
);

--import employees.csv

select * from employees

CREATE TABLE departments (
    dept_no     CHAR(4) NOT NULL,
    dept_name   VARCHAR(40) NOT NULL,
    PRIMARY KEY (dept_no)
);

--import departments.csv

select * from departments

CREATE TABLE dept_manager (
   dept_no CHAR(4) NOT NULL,
   emp_no INT NOT NULL,
   from_date DATE NOT NULL,
   to_date DATE NOT NULL,
   FOREIGN KEY (emp_no)  REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no,dept_no)
);

--import dept_manager.csv

select * from dept_manager

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no) ,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
);

--import dept_empt.csv

select * from dept_emp

CREATE TABLE titles (
    emp_no      INT NOT NULL,
    title       VARCHAR(50) NOT NULL,
    from_date   DATE NOT NULL,
    to_date     DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title, from_date)
);

--import titles.csv

select * from titles

CREATE TABLE salaries (
    emp_no      INT  NOT NULL,
    salary      INT  NOT NULL,
    from_date   DATE NOT NULL,
    to_date     DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date)
) ;

--import salaries.csv

select * from salaries

-- List details of each employee, last name, first name, gender, and salary

SELECT
e.emp_no,
e.last_name,
e.first_name,
e.gender,
s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

-- Employees hired in 1986

select * from employees
where extract(year from hire_date) = '1986';

-- List of managers from each dept by: dept no, dept name, manager's emp no, last name, first name, start/end date

SELECT
m.dept_no,
dept_name,
m.emp_no,
first_name,
last_name,
m.from_date,
m.to_date
FROM dept_manager m
LEFT JOIN departments on m.dept_no = departments.dept_no
LEFT JOIN employees on m.emp_no = employees.emp_no;

-- List departments of each employee by: emp no, last name, first name, and dept name

SELECT
e.emp_no,
last_name,
first_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no;

-- Selecting employees whose first name is Hercules and last name begins with B

SELECT * FROM employees
WHERE(first_name LIKE 'Hercules' AND last_name LIKE '%B%');

-- Display all employees in Sales Dept, employee no, first, last name, and dept name

Select
e.emp_no,
first_name,
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no
WHERE departments.dept_name lIKE 'Sales'

-- Displayall employees by: Sales Dept, Development Dept employee no, first, last name, and dept name

Select
e.emp_no,
first_name,
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no
WHERE departments.dept_name lIKE 'Sales'
OR departments.dept_name LIKE 'Development';

-- Displaying last name frequency

SELECT
last_name,
COUNT(last_name) AS "name_count"
from employees
GROUP BY
last_name
ORDER BY name_count DESC;
