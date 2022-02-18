--Challange for UNIT 7 -SQL:
--Delaverable 1: The Number of Retiring Employees by Title:
DROP TABLE departments;
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);
SELECT * FROM departments;

DROP TABLE employees CASCADE;
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR(40) NOT NULL,
     last_name VARCHAR(40) NOT NULL,
     gender VARCHAR(40) NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
SELECT * FROM employees;
DROP TABLE dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
DROP TABLE dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
SELECT * FROM dept_manager;
DROP TABLE salaries;
CREATE TABLE salaries (
	emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);
SELECT * FROM salaries;

DROP TABLE dept_emp;
CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no,dept_no)
);
SELECT * FROM dept_emp;

DROP TABLE titles;
CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR(20) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no,from_date)
);
SELECT * FROM titles;
-- Making some extra tables for some more insight for the final report:
SELECT e.first_name, e.last_name
INTO retiring_emp52
FROM employees as e
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT e.first_name, e.last_name
INTO retiring_emp53
FROM employees as e
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT e.first_name, e.last_name
INTO retiring_emp54
FROM employees as e
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--Number of employees retiring -challange condition 1-7:
DROP TABLE retirement_titles CASCADE;
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
--EXPORT TABLE retirement_titles HERE and also checked it looks like the one in our challange:
--Challange conditions 8-15:
-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE unique_titles CASCADE;
SELECT DISTINCT ON (rt.emp_no)
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE(rt.to_date='9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;
SELECT * FROM unique_titles;

DROP TABLE retiring_titles;
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;
SELECT * FROM retiring_titles;

--Deliverable 2: The Employees Eligible for Mentorship Program:
DROP TABLE mentorship_eligibilty CASCADE;
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, ti.from_date DESC;
SELECT * FROM mentorship_eligibilty;

--Deliverable 3: A written report with 2 more querries: 
--Q:1- HOw many roles will need to be filled :
DROP TABLE unique_titles_department CASCADE;
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	d.dept_name
INTO unique_titles_department
FROM retirement_titles as rt
INNER JOIN dept_emp as de
ON (rt.emp_no = de.emp_no)
INNER JOIN departments as d
ON (d.dept_no = de.dept_no)
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles_department;

SELECT ut.dept_name, ut.title, COUNT(ut.title) 
INTO rolls_to_fill
FROM (SELECT title, dept_name from unique_titles_department) as ut
GROUP BY ut.dept_name, ut.title
ORDER BY ut.dept_name DESC;

SELECT * FROM rolls_to_fill;

--Q:2- Are there enough qualified, retirement-ready employees in the depts to mentor the next generation of employees?
SELECT ut.dept_name, ut.title, COUNT(ut.title) 
INTO qualified_staff
FROM (SELECT title, dept_name from unique_titles_department) as ut
WHERE ut.title IN ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')
GROUP BY ut.dept_name, ut.title
ORDER BY ut.dept_name DESC;

SELECT * FROM qualified_staff;

