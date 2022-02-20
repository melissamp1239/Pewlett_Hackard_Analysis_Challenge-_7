--Query for retirement_titles.csv--
SELECT ce.emp_no, 
ce.first_name, 
ce.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_titles    
FROM employees AS ce
  INNER JOIN titles AS ti
  	ON (ce.emp_no = ti.emp_no)
WHERE birth_date BETWEEN '1952-01-01'AND'1955-12-31'
ORDER BY ce.emp_no;

SELECT * FROM retirement_titles

--Query for Unique Titles table--
-- Use Dictinct with Orderby to remove duplicate rows-----

SELECT DISTINCT ON(emp_no)rt.emp_no
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE to_date ='9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

--Query for retiring titles.csv--
--- Retrieving the number of employees by their most recent job title who are about to retire
SELECT COUNT(ut.title),title
INTO retiring_titles          
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;

--Deliverable Number 2
--*********--
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) Not NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no)REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no)REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
--Query for Mentorship_Eligibility Table---
---Employees Eligible for Mentorship Program Table--
SELECT DISTINCT ON (emp_no)ce.emp_no,
ce.first_name,
ce.last_name,
ce.birth_date,
de.from_date, 
de.to_date,
ti.title
INTO mentorship_eligibility
From employees AS ce
INNER JOIN dept_emp AS de
  	ON (ce.emp_no = de.emp_no)
INNER JOIN titles AS ti
    ON (ce.emp_no=ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01'AND'1965-12-31')
ORDER BY ce.emp_no;
	
SELECT * FROM mentorship_eligibility
