/* q1 */
SELECT phone, city, country from offices;

/* q2 */
SELECT * FROM orders WHERE comments LIKE "%fedex%"

/* Q4 */
SELECT customerName, contactFirstName, contactLastName FROM customers ORDER BY customerName DESC

/* Q5 */
SELECT * FROM employees where jobTitle = "Sales Rep" AND officeCode IN (1,2,3) 
AND (firstName LIKE "%son%" OR lastName LIKE "%son%")

/* Q3 */
SELECT orderNumber, contactFirstName, contactLastName
FROM customers
JOIN orders
ON orders.customerNumber = customers.customerNumber
WHERE orders.customNumber = 124;

/* Q6 */
SELECT productName, products.productCode, priceEach, orderNumber, orderLineNumber FROM
orderDetails JOIN products
 ON orderDetails.productCode = products.productCode

 /* Q7 */
SELECT customers.*, payments.* FROM
    customers JOIN payments
              ON customers.customerNumber = payments.customerNumber
    WHERE country="USA";

/* Extra: display the total amount paid by each customer */
 SELECT customers.customerNumber, customerName, SUM(amount) FROM payments
 JOIN customers ON payments.customerNumber = customers.customerNumber
 WHERE country="USA"
 GROUP BY customers.customerNumber, customerName

/* Q8 */
SELECT COUNT(*), state from employees JOIN offices
  ON offices.officeCode = employees.officeCode
  WHERE country="usa"
  GROUP BY state

/* Q9 */
SELECT AVG(amount), customers.customerNumber, customerName from payments
JOIN customers ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber, customerName

/* Q10 */
SELECT AVG(amount), customers.customerNumber, customerName from payments
JOIN customers ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber, customerName
HAVING AVG(amount) > 10000

