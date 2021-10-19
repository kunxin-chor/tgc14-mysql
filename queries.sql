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

/* Sort by ascending order */
SELECT * FROM customers ORDER BY creditLimit

/* Sort by descending order */
SELECT * FROM customers ORDER BY creditLimit DESC;

/* Displa the top ten customers by credit limit from the USA,
along with their sales rep */
SELECT customerName, creditLimit, employees.firstName, employees.lastName FROM customers 
JOIN employees ON
	customers.salesRepEmployeeNumber = employees.employeeNumber
WHERE country="USA"
ORDER BY creditLimit DESC
LIMIT 10;

/* SELECT BY A DATE */
SELECT * FROM orders WHERE orderDate="2003-01-10"

/* Get all the orders in Jan 2003 */
SELECT * FROM orders WHERE orderDate >= "2003-01-01"
AND orderDate <="2003-01-31";

SELECT * FROM orders WHERE orderDate 
    BETWEEN '2003-01-01' AND '2003-01-31';

/* Select all orders made up to 3 days ago */
SELECT * from orders WHERE DATEDIFF(CURDATE(), orderDate) <= 3;

/* Extract out the year, month, day component of a date */
SELECT orderNumber, YEAR(orderDate), MONTH(orderDate), DAY(orderDate) FROM orders;
/* display all the orders that are placed in the year 2004 */
SELECT * FROM orders WHERE YEAR(orderDate)=2004;

/* display all the orders that are placed in the year 2004 and in June */
SELECT * FROM orders WHERE YEAR(orderDate)=2004 AND MONTH(orderDate)=6;

/* display the lag days between placing an order and shipping it */
SELECT *, shippedDate - orderDate as "lag" FROM orders 

/** AGGREATES **/
/* Show how many employees there are */
SELECT COUNT(*) FROM employees;

/* Display the number of customers from the USA */
SELECT COUNT(*) FROM customers WHERE country="USA";

/* Display all countries the customers are from, with duplicates removed */
SELECT DISTINCT(country) FROM customers;
SELECT SUM(creditLimit) FROM customers;
SELECT MIN(creditLimit) FROM customers WHERE creditLimit > 0;
SELECT MAX(creditLimit) FROM customers;

/* display the number of employees for each office */
/* display the number of employees per office */
SELECT COUNT(*), officeCode FROM employees
GROUP BY officeCode

/* display the average credit limit of customers from each country */
SELECT country, AVG(creditLimit) as "average_credit_limit" from customers
GROUP BY country

/* display the sum of all amount collected by year */
SELECT SUM(amount), YEAR(paymentDate) FROM payments
GROUP BY YEAR(paymentDate)

/* Display the numebr of sales rep for each city */
select employees.officeCode, city, count(*) from employees
join offices
  on employees.officeCode = offices.officeCode
where jobTitle="Sales Rep"
group by employees.officeCode, city

/* Only display offices with three or more sales rep */
select employees.officeCode, city, count(*) from employees
join offices
  on employees.officeCode = offices.officeCode
where jobTitle="Sales Rep"
group by employees.officeCode, city
having count(*) >= 3
order by count(*)

/* Show all the year and month where the total amount of payment collected
is greater than 30000 */
SELECT SUM(amount), YEAR(paymentDate), MONTH(paymentDate) FROM payments
GROUP BY YEAR(paymentDate), MONTH(paymentDate)
HAVING SUM(amount) > 30000