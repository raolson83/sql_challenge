-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "Departments" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(10)   NOT NULL
);


CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR(10)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(10)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(10)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR(10)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


-- Import data into tables was done without code, manually importing
SELECT * FROM "Departments";
SELECT * FROM "Dept_emp"; 
SELECT * FROM "Dept_manager";
SELECT * FROM "Employees";
SELECT * FROM "Salaries";
SELECT * FROM "Titles";


-- 1) List the employee number, last name, first name, sex, and salary of each employee.

SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary 
FROM "Employees" AS emp
INNER JOIN "Salaries" AS sal
USING(emp_no); 

-- 2) List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT last_name, first_name, hire_date
FROM "Employees" 
WHERE hire_date > '1985-12-31' AND hire_date < '1987-01-01';

-- 3) List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dept_man.emp_no, emp.last_name, emp.first_name,  dept_man.dept_no, dept.dept_name 
FROM "Dept_manager" AS dept_man
JOIN "Employees" AS emp
USING(emp_no)
JOIN "Departments" AS dept
USING(dept_no);
	
-- 4) List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no, dept_emp.emp_no, emp.last_name, emp.first_name, dept.dept_name 
FROM "Dept_emp" AS dept_emp
JOIN "Employees" AS emp
USING(emp_no)
JOIN "Departments" AS dept
USING(dept_no);

-- 5) List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6) List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp.emp_no, emp.last_name, emp.first_name
FROM "Employees" AS emp
JOIN "Dept_emp" AS dept_emp
USING(emp_no)
JOIN "Departments" AS dept
USING(dept_no)
WHERE dept.dept_name = 'Sales';

-- 7) List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM "Employees" AS emp
JOIN "Dept_emp" AS dept_emp
USING(emp_no)
JOIN "Departments" AS dept
USING(dept_no)
WHERE dept.dept_name IN ('Sales', 'Development') ;

-- 8) List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name) AS "Last Name"
FROM "Employees"
GROUP BY last_name
ORDER BY "Last Name" DESC;
