create database PROJECT;
use project;

insert into sales_data 
(Product_ID, Sale_Date, Sales_Rep, Region, Sales_Amount, Quantity_Sold, Product_Category, 
Unit_Cost, Unit_Price, Customer_Type, Discount, Payment_Method, Sales_Channel, Region_and_Sales_Rep)
value 
(101, '2025/03/01', 'John Doe', 'North', 5000.00, 50, 'Electronics', 80.00, 120.00, 
'Retail', 10.00, 'Credit Card', 'Online', 'North - John Doe');

-- 1. select all records
select * from sales_data;

-- 2. what are the total sales amount
select sum(sales_amount) as total_amount from sales_data;

-- 3. What are the total quantities sold for each product category over a specific time period
select product_category, sum(quantity_sold) as total_quantity
from sales_data
group by product_category;

-- 4. find the top 5 sales representatives based on sales amount
select sales_rep, sum(sales_amount) as total_sales
from sales_data
group by sales_rep
order by total_sales desc
limit 5;

-- 5. find the number of product categary with payment method is cash
select count(distinct product_category) as total_categories 
from sales_data where payment_method = 'cash';

-- 6. Sort the prodcut category alphabetically and then sort on the basis of sales amount in ascending order
select product_category,sales_Amount from sales_data
order by product_category,sales_Amount asc;

-- 7.find the highest sold amonut of product category
select product_category, max(sales_amount) as highest_sales  
from sales_data  
group by product_category  
order by highest_sales desc  
limit 1;  

-- 8.how many are the sales represetative 
select count(distinct (sales_rep)) as all_SalesRep from sales_data;

-- 9.find latest sales  
select * from sales_data order by sale_date limit 1;

-- 10.Get the total sales amount for a product category is electronics
select product_category,sum(sales_amount) from sales_data where product_category = 'electronics';

-- 11.find the top 3 Rank sales representatives by total sales amount:

select sales_rep, sum(sales_amount) as top_sales,rank() 
over (order by sum(sales_amount) desc) as sales_Rank
from sales_data  group by sales_rep limit 3;  


-- 12.count the sales by the region
select region, count(*) as sales_count from sales_data group by region;

-- 13. Find the avg unit_price of all the catergory  with avg discount >10 and sales channel is online
select product_category ,avg(Unit_Price)
from sales_data where Sales_Channel = 'online'
group by product_category having avg(Discount) <1;

-- 14.Find the sales representative  who have highest discout  
 
 select sales_rep, sum(discount) as total_discount  
from sales_data  
group by sales_rep limit 1 ;

-- 15.find products sold by different sales representative
select a.product_id, a.sales_rep as rep_1, b.sales_rep as rep_2, a.region
from sales_data a
join sales_data b on a.product_id = b.product_id;


-- 16. find all the categaory that have rating higher than average rating of movies in the same genre
select * from movies m1 where score>(select avg(score) from movies m2 where m1.genre-m2.genre);

-- 17.Get Product_Category sold at the highest discount

select product_id, product_category, discount  from sales_data  
where discount = (select max(discount) from sales_data); 
 
 -- 18.find top Product_Category which a product with a price higher than the average unit price

select distinct Product_Category,unit_price  
from sales_data  
where unit_price > (select avg(unit_price) from sales_data) limit 1;


