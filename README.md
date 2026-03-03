# Consumer-Goods-Ad-Hoc-Insights 
# 📄 [Codebasics Resume Project challenge - 4](https://codebasics.io/challenges/codebasics-resume-project-challenge/7)


## Problem statement

The management did observe, though, that they do not receive enough information to enable them to make prompt, well-informed decisions. 
They wish to add a number of junior data analysts to their data analytics team. Their director of data analytics, Tony Sharma, was looking for a candidate with both technical and soft skills. 
In order to better understand both skills, he made the decision to conduct a SQL challenge and seeks insights for 10 ad-hoc request.


### [Task List](https://github.com/Nikhil-Rane108/-Consumer-Goods-Ad-Hoc-Insights/blob/main/ad-hoc-requests.pdf)

1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, unique_products_2020 unique_products_2021 percentage_chg

3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields,
segment product_count

4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, segment product_count_2020 product_count_2021 difference

5. Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields, product_code     product     manufacturing_cost

6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields,    customer_code    customer    average_discount_percentage

7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. This analysis helps to get an idea of low and high-performing months and take strategic decisions.
The final report contains these columns:    Month    Year    Gross sales Amount

8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,
Quarter total_sold_quantity

9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
channel    gross_sales_mln    percentage

10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields,
division    product_code     product    total_sold_quantity    rank_order

## Data Model

<p align="center">
    <img src="https://github.com/Nikhil-Rane108/-Consumer-Goods-Ad-Hoc-Insights/blob/main/sql%20data%20model.png" height="400">
</p>


## Analysis View  

<p align="center">
    <img src="https://github.com/Nikhil-Rane108/Hospitality-Analysis-Dashboard/blob/main/dashboard%20home%20page.png" width="600">
</p>


## Some Important insights from the Dashboard

- Mumbai generates the highest revenue (669 M) followed by Bangalore, Hyderabad and Delhi
- AtliQ Exotica performs better compared to all 7 type of properties with 320 Million revenue, rating 3.62, occupancy percentage 57 and cancellation rate as 24.4%.
- AtliQ Bay has the highest occupancy of 66%
- Week 24 recorded the highest revenue among all, which is 139.6 Million
- Delhi tops both in occupancy and rating followed by Hyderabad, Mumbai, Bangalore
- AtliQ lost around 298 Million in cancellation 
- Elite type rooms has the most booking and as well higher cancellation rate
