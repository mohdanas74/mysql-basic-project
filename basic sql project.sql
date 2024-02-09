#1) Show customer number, customer name, state and credit limit from customers table for below conditions. Sort the results by highest to lowest values of creditLimit.
-- ● State should not contain null values -- ● credit limit should be between 50000 and 100000

select customerNumber,customername,state,creditlimit from customers where state is NOT NULL AND creditlimit >50000 and creditlimit < 100000 order by creditlimit desc;

# 2) Show the unique productline values containing the word cars at the end from products table.
select DISTINCT productline from products where productline like '%cars' ;

# 3) Show the orderNumber, status and comments from orders table for shipped status only. If some comments are having null values then show them as “-“.
SELECT ordernumber, status, 
CASE WHEN comments IS NULL THEN '_'  ELSE comments END AS comments 
FROM orders WHERE status = 'shipped';

/*4) Select employee number, first name, job title and job title abbreviation from employees table based on following conditions. If job title is one among the below conditions, 
then job title abbreviation column should show below forms.
● President then “P” 
● Sales Manager / Sale Manager then “SM”
● Sales Rep then “SR” 
● Containing VP word then “VP”*/
SELECT employeeNumber,firstname,jobtitle,
         CASE
             WHEN jobtitle = 'President' THEN 'P'
             WHEN jobtitle LIKE '%Sales Manager%' THEN 'SM'
             WHEN jobtitle LIKE '%Sale Manager%' THEN 'SM'
             WHEN jobtitle = 'Sales Rep' THEN 'SR'
             WHEN jobtitle LIKE '%VP%' THEN 'VP'
             ELSE jobtitle -- Default case
         END AS job_title_abbreviation
     FROM employees;
     
    # 5) For every year, find the minimum amount value from payments table
select YEAR(paymentDate) as Year ,
MIN(amount) as Amount from payments
 GROUP BY YEAR(paymentDate);

# 6) For every year and every quarter, find the unique customers and total orders from orders table. Make sure to show the quarter as Q1,Q2 etc.
SELECT YEAR(orderDate) as Year,
 CONCAT('Q',QUARTER(orderDate)) as Quarter,COUNT(DISTINCT customerNumber) 
as unique_customers,
COUNT(orderNumber) as total_orders
 FROM orders 
 GROUP BY YEAR(orderDate), Quarter;
 
 #7) Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.)with filter on total amount as 500000 to 1000000. Sort the output by total amount in descending mode. [ Refer. Payments Table]
 SELECT DATE_FORMAT(paymentDate, '%b') AS month, 
CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS formattedAmount 
FROM payments 
GROUP BY month 
HAVING SUM(amount) BETWEEN 500000 AND 1000000 
ORDER BY SUM(amount) DESC;