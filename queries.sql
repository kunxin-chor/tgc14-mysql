/* display only certain columns from a table */
SELECT firstName, lastName, email FROM employees;

/* display rows only a column meets certain critera
i.e where job title is "Sales Rep" */
SELECT * FROM employees WHERE jobTitle="Sales Rep";

/* only display certain columns and certain rows */
SELECT firstName, lastName, email, jobTitle FROM 
    employees WHERE jobTitle="Sales Rep";

/* Use LIKE to search by substring (in-case sensitive) */
SELECT * FROM employees WHERE jobTitle LIKE "%sales%";

/* display customers from Singapore */
SELECT customerName, addressLine1, addressLine2 from customers where country = "Singapore"

/* display all customers with the word 'gift' in their name */
SELECT customerName, addressLine1, addressLine2 FROM customers where customerName like "%gift%";

/* display all employees who are from office code 1 or office code 2 */
SELECT * FROM employees WHERE officeCode="1" OR officeCode="2";

/* display all sales rep from office code 1 */
SELECT * FROM employees WHERE officeCode="1" AND jobTitle="Sales Rep"

/* display all the employees that are not saled rep */
select * from employees where jobTitle != "Sales Rep"

/* display all employees in office code 1, 2 or 3 */
select * from employees where officeCode in (1,2,3)

/* display all employees not from office code 1, 2 or 3) */
select * from employees where officeCode NOT IN (1,2,3)

/* display the city that all sales rep all working in */
select * from employees join offices
on employees.officeCode = offices.officeCode
where employees.jobTitle = "Sales Rep";

/* for each customer, display the customer name and the first name
and last name of their sales rep */
SELECT customerName, firstName, lastName, email FROM customers JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber;

/* display for customer, their sales rep and city their office is in */
SELECT customerName, firstName AS "Sales Rep First Name", lastName AS "Sales Rep Last Name", offices.city AS "Office City" FROM customers 
  JOIN employees
  ON customers.salesRepEmployeeNumber = employees.employeeNumber
  JOIN offices
  ON employees.officeCode = offices.officeCode;

SELECT * from eating_places
 WHERE food_quality > 5
 AND price < 20