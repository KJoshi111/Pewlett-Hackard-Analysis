--Unit 7 SQL Challenge
--Deliverable 1:The number of Retiring Employees by Title.
--Create table for Retirement Titles:
CREATE TABLE employees(
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);
SELECT * FROM employees;
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR(20) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);
SELECT * from titles;
SELECT emp_no,first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT title,from_date,to_date

SELECT e.emp_no,
	e.first_name, 
	e.last_name, 
	ti.title, 
	ti.from_date, 
	ti.to_date	
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
	WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;
SELECT * FROM retirement_titles;
-- Use Dictinct with Orderby to remove duplicate rows as per started code 

SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
--condition 11 from challange deliverable 1.
WHERE(rt.to_date='9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT COUNT(ut.first_name)
FROM unique_titles as ut;
--printing to check 
SELECT * from unique_titles;
--Another query in this file to retrive the number of employees by their most recent job title who are about to retire.
--instructions 16-22

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;
SELECT * FROM retiring_titles;

--Deliverable 2:The Employee Eligible for the Mentorship Program
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
PRIMARY KEY(emp_no, dept_no)
);
SELECT * FROM dept_emp;
DROP TABLE mentorship_eligibility;

SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON(e.emp_no=ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01'AND '1965-12-31')
AND (de.to_date='9999-01-01')
ORDER BY e.emp_no, ti.from_date DESC;
Select * FROM mentorship_eligibility;

