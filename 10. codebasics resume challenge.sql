/* #1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.*/

select distinct market
from dim_customer
where customer="Atliq Exclusive" and region="APAC";

/*2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
unique_products_2020, unique_products_2021, percentage_chg */
with prod2020 as (
	select count(distinct product_code) as unique_product_2020
	from fact_sales_monthly
    where fiscal_year=2020
),
    prod2021 as (
	select count(distinct product_code) as unique_product_2021
	from fact_sales_monthly
    where fiscal_year=2021
)
select *,
		(unique_product_2021-unique_product_2020)*100/unique_product_2020 as pct_chg
from prod2020 cross join prod2021;

/* 3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. 
The final output contains 2 fields,
segment, product_count */

select segment,count(distinct product_code) as product_cnt
from dim_product
group by segment
order by product_cnt desc;

/*4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields,
segment, product_count_2020, product_count_2021, difference */
with seg20 as (
	select  p.segment,
			count(distinct p.product_code) as product_cnt20
	from dim_product p
    left join fact_sales_monthly s
    on p.product_code = s.product_code
	where fiscal_year=2020
	group by p.segment
	order by product_cnt20 desc
),
	seg21 as (
	select  p.segment,
			count(distinct p.product_code) as product_cnt21
	from dim_product p
    left join fact_sales_monthly s
    on p.product_code = s.product_code
	where fiscal_year=2021
	group by p.segment
	order by product_cnt21 desc
)
select  s.segment,s.product_cnt20,
		g.product_cnt21,
		g.product_cnt21 - s.product_cnt20 as difference
from seg20 s
join seg21 g
using (segment);

/*5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields,
product_code, product, manufacturing_cost */

select p.product_code,p.product,f.manufacturing_cost
from fact_manufacturing_cost f
join dim_product p
on f.product_code = p.product_code
where manufacturing_cost in (
	(select min(manufacturing_cost)from fact_manufacturing_cost) ,
	(select max(manufacturing_cost) from fact_manufacturing_cost))
;    
/* 6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the 
fiscal year 2021 and in the Indian market. The final output contains these fields,
customer_code, customer, average_discount_percentage */

select  c.customer_code, c.customer, d.pre_invoice_discount_pct 
from fact_pre_invoice_deductions d
join dim_customer c
on c.customer_code = d.customer_code
where pre_invoice_discount_pct >= (select avg(pre_invoice_discount_pct) from fact_pre_invoice_deductions)
and market="India" and fiscal_year=2021
order by pre_invoice_discount_pct desc limit 5;

/* 7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. This analysis helps 
to get an idea of low and high-performing months and take strategic decisions. The final report contains these columns:
Month, Year, Gross sales Amount */

select  monthname(s.date) as month,
		s.fiscal_year,
		sum(s.sold_quantity * g.gross_price) as gross_sales_amt
from fact_sales_monthly s
join dim_customer c
on c.customer_code = s.customer_code

join fact_gross_price g
on  g.product_code = s.product_code
and g.fiscal_year = s.fiscal_year

where customer like "%Atliq Exclusive%"
group by month,fiscal_year
order by s.date;

/*8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the 
total_sold_quantity:	Quarter, 	total_sold_quantity */
select 	sum(sold_quantity) as sold_quantity,
		case
			when month(date) in (9,10,11) then "Q1"
            when month(date) in (12,1,2) then "Q2"
            when month(date) in (3,4,5) then "Q3"
            else "Q4"
        end as quarter
from fact_sales_monthly
where fiscal_year=2020
group by quarter
order by sold_quantity desc
;
/* 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
The final output contains these fields, 	channel, 	gross_sales_mln, 	percentage */

with cte1 as(
select  c.channel,
		round(sum(s.sold_quantity * g.gross_price)/1000000,2) as gross_sales_mln
from dim_customer c
join fact_sales_monthly s
on c.customer_code = s.customer_code

join fact_gross_price g
on  g.product_code=s.product_code and
	g.fiscal_year=s.fiscal_year

where s.fiscal_year= 2021
group by c.channel
)
select *,
		gross_sales_mln*100/sum(gross_sales_mln) over() as pct_conrtibution
from cte1;


/* 10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
The final output contains these fields, 	division, 	product_code, 	product, 	total_sold_quantity, 	rank_order */

with cte1 as (
select  p.division,s.product_code,p.product,
		sum(s.sold_quantity) as total_sold_quantity,
		rank() over(partition by division order by sum(s.sold_quantity) desc) as dns_rank
from fact_sales_monthly s
join dim_product p
using (product_code)
where fiscal_year=2021
group by p.division,p.product_code,p.product
)
select *
from cte1
where dns_rank <= 3
