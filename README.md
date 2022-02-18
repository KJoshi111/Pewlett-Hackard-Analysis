# Pewlett-Hackard-Analysis

## Overview of the Analysis:
The purpose of this analysis was to utilize our knowledge of SQL to help a big company of around 300,000 employees by analysing the employee data to determine the number of retiring employees: per title and per departments, and also to identify the employees that are eligible to participate in a mentorship program. With this the company will be better prepared for the future where a "Silver Tsunami" is predicted.

## Results:
### A Few Things I Found Were: 

#### 1. In Deliverable 1 we created a list of employees retiring by titles by merging two tables- employees and titles. Which shows us 133,777 are retiring between the given period. Here is a snapshot of our retirement_titles table:

![retirement titles](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/retirement_titles.png)

#### 2. Then we used the DISTINCT ON function to show the list of the employees who are currently working and have not left yet, and we stored it in the unique_titles table , which shows 72,459 employees. This helps us as we are working with comparatively large data and now we are analysing around 72,000 employees rather than 133,000.
Here is an image of our unique_titles table:

![unique titles](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/unique_titles.png)

#### 3. In Deliverable 2, we are finding the eligibility of retiring employees on the company's mentorship program. We are using all the data we have, and by applying our knowledge of joining the tables and applying conditions, we create a new table out of the datasets we had earlier, and that table is called "mentorship_eligibility.
Here is a picture of our table:

![mentorship eligibility](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/mentorship_eligibility.png)

#### 4. We came to a conclusion that around 1500 employees are eligible for the mentorship program out of all the employees retiring and still with the company. In our query we also made tables for years 1952, 1953, and 1954 showing retiring employees in those years and saved in our data folder. We can send this list to the managers of their department and they can plan a sweet farewell for those employees with their team. This can be a very good team-building activity for them all.

Retiring Employees in 1952:
![retiring employees 1952](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/retiring_emp52.png)

Retiring Employees in 1953:
![retiring employees 1953](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/retiring_emp53.png)

Retiring Employees in 1954:
![retiring employees 1954](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/retiring_emp54.png)

## Summary: 
### Question 1: How many roles will need to be filled as the "Silver Tsunami" begins to make an impact?
We prepared a table named roles_to_fill, which shows how many employees we need to hire in each department. We added filter to the dept_name column and it shows that a development department needs 23,937 roles and a production department needs the second highest number of employees, 20,449 employees, to be hired.
Here is a snapshot of our table:

![roles to fill](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/roles_to_fill.png)

### Question 2: Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
To answer this question, we prepared a new table called qualified_staff, and with the support of our table, we can conclude that overall we have enough trained and experienced staff who are retiring and are eligible for our mentorship program in each and every department, apart from management level in the Sales department. So that will be our department to focus on. We have two options: either we hire a batch of employees and our senior manager from Sales department can mentor them, or we can hire experienced individuals for this role and give them some online training. Our Research and Development team can create online training modules for us.
Here is a snapshot of the qualified_staff table:

![qualified staff](https://github.com/KJoshi111/Pewlett-Hackard-Analysis/blob/main/Tables/qualified_staff.png)
