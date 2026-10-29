/*what are the overall, profit, and profit margin
of the superstore business*/

select 
sum(sales) as Total_sales,
sum(profit) as total_profit,
(sum(profit) / sum(sales)) * 100
from Superstore_Cleaned;

/* Which category generates the most sales and profit */

select 
   category,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   (sum(profit) / sum(sales)) * 100
   as Profit_margin
   from Superstore_Cleaned
   group by category
   order by Total_profit desc;


/* Which sub_category generate the most sales and profit*/

select 
   category,
   sub_category,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   (sum(profit) / sum(sales)) * 100
   as Profit_margin
   from Superstore_Cleaned
   group by category, Sub_Category
   order by Total_profit desc;

/*Which sub_category are losing money?*/

select 
   category,
   sub_category,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   (sum(profit) / sum(sales)) * 100
   as Profit_margin
   from Superstore_Cleaned
   group by category, Sub_Category
   having sum(profit) < 0
   order by Total_profit desc;

/* which region generate the most sales and
profit, and what is their profit margin ? */

select 
  region,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   (sum(profit) / sum(sales)) * 100
   as Profit_margin
   from Superstore_Cleaned
   group by region
   order by Total_profit desc;

/* which customer segment generates the most sales and profit? */

select
   segment,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   (sum(profit) / sum(sales)) * 100
   as profit_margin
   from Superstore_Cleaned
   group by Segment
   order by Total_profit desc;  

/* Find total_sales, Total profit , and profit margin
for each discount level */

select
   discount,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   (sum(profit) / sum(sales)) * 100
   as profit_margin
   from Superstore_Cleaned
   group by Discount
   order by Total_profit desc; 

/* Which cities generate the highest Total sales 
and profit */ 

select
    city,
    sum(sales) as Total_sales,
    sum(profit) as Total_profit
from Superstore_Cleaned
group by City
order by Total_sales desc;

/* Which sub_category sell the most units? */

select
    Sub_Category,
    sum(Quantity) as Total_quantity,
    sum(Sales)as Total_sales
from Superstore_Cleaned
group by Sub_Category
order by Total_quantity desc;

/* which 5 sub-category generate the highest profit? */

select Top 5
   sub_category,
   sum(profit) as Total_profit,
   sum(sales) as Total_sales
from Superstore_Cleaned
group by Sub_Category
order by Total_profit desc;

/* Within each category, which are the top 2
sub_categories by profit? */

with SubCategoryData as (
  select
      Category,
      sub_category,
      sum(sales) as Total_sales,
      sum(profit) as Total_profit
      from Superstore_Cleaned
      group by Category, Sub_Category
),
RankedData as (
  select 
     Category,
     sub_category,
     Total_sales,
     Total_profit,

     rank() over(
       partition by category
       order by Total_profit desc
     )as Profit_rank
     from subcategoryData
)
select 
  Category,
  sub_category,
  Total_sales,
  Total_profit,
  Profit_rank
  from rankeddata
  where Profit_rank <= 2


/* find Top 3 cities based on total profit , but only
include cities that have more than 10 order */

select top 3
   city,
   sum(sales) as Total_sales,
   sum(profit) as Total_profit,
   count(*) as Total_orders
from Superstore_Cleaned
group by city
Having count(*) > 10
order by total_profit desc;