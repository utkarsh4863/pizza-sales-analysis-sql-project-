# pizza-sales-analysis-sql-project-

# Pizza Sales Analysis

## Overview

This repository contains the **database schema** and **SQL queries** for analyzing pizza sales data. It models pizza types, sizes, prices, orders, and detailed order information to provide insights into sales performance and customer preferences.

## Database Schema

The schema consists of four main tables:

- **pizza_types**: Contains details about pizza types including their category and ingredients.
- **pizzas**: Stores individual pizzas with their sizes and prices linked to pizza types.
- **orders**: Records order information with date and time.
- **order_details**: Tracks quantity and types of pizzas ordered per order.

## SQL Queries

Included SQL queries perform analyses such as:

- Calculating total revenue from pizza sales.
- Identifying the highest-priced pizzas.
- Finding the most common pizza sizes ordered.
- Listing the top ordered pizza types by revenue and quantity.
- Analyzing category-wise revenue contributions.
- Calculating cumulative revenue over time.
- Determining order distribution by hour of day.

## How to Use

1. Use the `pizza_sales_schema.sql` file to create the database tables.
2. (Optional) Load sample data into the database.
3. Run queries from the `pizza_sales_analysis.sql` file to generate insights.
4. You can connect this database with BI tools for advanced visualization and reporting.

## Technologies

- SQL (compatible with MySQL, PostgreSQL, and other relational databases)
- Designed for integration with data visualization tools
- 



