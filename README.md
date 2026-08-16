# SupplyChainDWH – Supply Chain Data Warehouse & Power BI Dashboard

## 📌 Project Overview

**SupplyChainDWH** is an end-to-end Data Warehouse and Business Intelligence project built to analyze supply chain, sales, customers, products, salesmen, and logistics performance.

The project follows a **Medallion Architecture**:

**Bronze → Silver → Gold → Power BI**

The main goal was to transform raw supply chain data into a clean analytical model and build an interactive Power BI dashboard that answers important business questions related to:

- Sales & Revenue
- Profitability
- Customers
- Products
- Salesmen Performance
- Shipping & Delivery
- Markets & Regions
- Business Trends

---

# 🏗️ Architecture

```text
Raw Source Data
      │
      ▼
┌─────────────┐
│   Bronze    │
│ Raw Data    │
└──────┬──────┘
       │
       │ Cleaning & Transformation
       ▼
┌─────────────┐
│   Silver    │
│ Clean Data  │
└──────┬──────┘
       │
       │ Dimensional Modeling
       ▼
┌─────────────┐
│    Gold     │
│ Star Schema │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Power BI   │
│ Dashboard   │
└─────────────┘
```
🛠️ Tools & Technologies
SQL Server
T-SQL
Power BI
DAX
Star Schema
Medallion Architecture
Power BI Data Modeling
🥉 Bronze Layer

The Bronze layer stores the raw source data with minimal transformation.

The purpose of this layer is to preserve the original data and provide a reliable source for the following transformation stages.

Example source entities include:

Customers
Products
Salesmen
Orders
Order Items
Order Dates
Shipping Dates
🥈 Silver Layer

The Silver layer contains cleaned and standardized data.

Main transformations included:

Data type conversion
Cleaning inconsistent values
Standardizing column names
Handling duplicate column definitions
Preparing business-ready tables
Preserving the required records from Bronze

A major validation step was performed to make sure the Silver layer retained the expected data without unintended row loss.

🥇 Gold Layer

The Gold layer was designed specifically for analytics and Power BI.

A Star Schema was used, consisting of:

Dimension Tables
```text
DimCustomers
DimProducts
DimSalesman
DimOrderDate
DimShippingDate
```
Fact Table
```text
FactOrders
```
⭐ Gold Layer Model
DimCustomers

Contains customer-related analytical attributes.

Main columns:

Customer_Id
Customer_Full_Name
Customer_Birth_Date
Customer_Street
Customer_City
Customer_State
Customer_Country
Customer_Segment
Latitude
Longitude
Data Privacy

Sensitive customer information was intentionally excluded from the Gold layer:

Email
Password

The ZIP Code was also excluded because it was not considered useful for the intended analysis.

DimProducts

The product structure was kept as a single analytical dimension rather than splitting Product, Category, and Department into separate dimensions.

Main columns:

Product_Card_Id
Product_Name
Product_Price
Product_Status
Product_Description
Category_Id
Category_Name
Department_Id
Department_Name

This structure makes it easy to analyze revenue across:
```text
Department
    ↓
Category
    ↓
Product
```
DimSalesman

Contains sales representative information used for performance analysis.

Main columns:

Salesman_Id
Salesman_Full_Name
Market
Region
Hire_Date
Commission_Rate

Salesman email was excluded because it has no analytical value for the dashboard.

DimOrderDate

Dedicated date dimension for order analysis.

Main columns:

Date_Key
Full_Date
Day
Month
Month_Name
Quarter
Year
DimShippingDate

A separate date dimension was created for shipping analysis.

Main columns:

Date_Key
Full_Date
Day
Month
Month_Name
Quarter
Year

Having separate Order Date and Shipping Date dimensions allows the model to analyze sales timing and shipping timing independently.

📦 FactOrders

FactOrders represents the transactional/order-item level of the business process.

Main fields include:

Order_Id
Order_Item_Id
Customer_Id
Product_Card_Id
Salesman_Id
Order_Date_Key
Shipping_Date_Key
Order_Item_Quantity
Order_Item_Discount
Order_Item_Total
Order_Item_Profit_Ratio
Benefit_per_order
Shipping_Mode
Delivery_Status
Days_for_shipment_scheduled
Days_for_shipping_real
Late_delivery_risk
Order_Status
Order_Region
Order_State
Market
Type
Important Modeling Decision

Order_Item_Id was treated as an order-item identifier, not as a Product ID.

One order can contain multiple order items, therefore the fact table operates at the order-item level.

For example:
```text
Order 1001
 ├── Order Item 1 → Product A
 ├── Order Item 2 → Product B
 └── Order Item 3 → Product C
```
This allows detailed analysis of products, quantities, revenue, discounts, and profitability.

📊 Data Volume

The Gold layer contains approximately:

Table	Rows
DimCustomers	20,652
DimProducts	118
DimSalesman	603
DimOrderDate	1,127
DimShippingDate	1,131
FactOrders	180,519

The fact table contains order-item level records, so the number of fact rows is higher than the number of distinct orders.

📈 Power BI Dashboard

The final Power BI report contains 5 analytical pages:

Overview
Customer
Products
Sales & Logistics
Salesman

The dashboard was designed so that the Overview page gives a quick business summary, while the other pages provide deeper analysis.

1️⃣ Overview

The Overview page provides a high-level view of the business.

KPIs
Total Revenue
Total Orders
Total Customers
Total Profit
Late Delivery Rate
Visualizations
Revenue Trend

Shows how revenue changes over time.

Revenue by Market

Shows the contribution of each market to total revenue.

Markets were grouped into:

Europe
LATAM
Pacific Asia
USCA
Africa
Delivery Status

Shows the distribution of orders across:

Late Delivery
Advance Shipping
Shipping on Time
Shipping Cancelled
Key Business Questions
How much revenue is being generated?
How profitable is the business?
How many orders and customers are being served?
Which markets generate the most revenue?
How significant is the delivery problem?
2️⃣ Customer Analysis

The Customer page focuses on customer segmentation and geographic distribution.

Visualizations
Customer Distribution by Segment

Shows the customer mix across:

Consumer
Corporate
Home Office
Revenue by Segment

Compares revenue generated by each customer segment.

Customers by Country

Shows customer concentration by country.

Top 5 States

Identifies the states with the highest number of customers.

Customer Geographic Map

Displays the geographical distribution of customers using latitude and longitude.

Key Business Questions
Which customer segment is the largest?
Which segment generates the most revenue?
Where are customers concentrated?
Which states contain the largest customer base?
Where are customers geographically distributed?
3️⃣ Products Analysis

The Products page focuses on product portfolio performance.

KPIs
Total Products
Total Categories
Total Quantity
Visualizations
Revenue by Department

Identifies the departments generating the highest revenue.

Top 10 Products by Revenue

Highlights the best-performing products.

Revenue by Category

Compares revenue generated across product categories.

Key Business Questions
Which departments drive the most revenue?
Which products are the top revenue generators?
Which categories contribute most to sales?
How large is the product portfolio?
Which product categories may require more attention?
4️⃣ Sales & Logistics

This page combines sales performance with shipping and delivery analysis.

KPIs
Total Revenue
Total Profit
Total Orders
Late Delivery Rate
Visualizations
Revenue by Market

Compares revenue across the major market groups.

Revenue Trend

Shows revenue development over time.

Late Delivery Rate by Shipping Mode

Compares delivery performance across:

First Class
Second Class
Same Day
Standard Class
Actual vs Scheduled Shipping

Compares:

Average Actual Shipping Days
Average Scheduled Shipping Days

This helps identify differences between planned and actual shipping performance.

Key Business Questions
Which markets generate the most revenue?
How does revenue change over time?
Which shipping modes have the highest late-delivery rate?
Are actual shipping times higher than scheduled times?
Where are the major logistics issues?
5️⃣ Salesman Analysis

The Salesman page focuses on individual sales representative performance.

KPIs
Total Salesmen
Average Revenue per Salesman
Average Profit per Salesman
Visualizations
Top 10 Salesmen by Revenue

Identifies the salesmen generating the highest revenue.

Top 10 Salesmen by Profit

Identifies the salesmen generating the highest profit.

Revenue by Region

Shows revenue contribution across sales regions.

Commission Rate vs Revenue

A scatter chart was used to investigate:

Does a higher commission rate correspond to higher revenue?

The chart uses:

X-Axis → Commission Rate
Y-Axis → Total Revenue
Details → Salesman Full Name

This provides a way to identify patterns and potential outliers between commission rates and revenue performance.
📐 DAX Measures

Several DAX measures were created to support the analysis.

Examples include:
```text
Total Revenue =
SUM('Gold FactOrders'[Order_Item_Total])

Total Profit =
SUM('Gold FactOrders'[Benefit_per_order])

Total Orders =
DISTINCTCOUNT('Gold FactOrders'[Order_Id])

Total Customers =
DISTINCTCOUNT('Gold FactOrders'[Customer_Id])

Total Salesmen =
DISTINCTCOUNT('Gold DimSalesman'[Salesman_Id])

Total Quantity =
SUM('Gold FactOrders'[Order_Item_Quantity])
```
The dashboard also includes measures for:

Average Revenue per Salesman
Average Profit per Salesman
Late Delivery Rate
Revenue by market
Revenue by region
Revenue by product
Revenue by category
Revenue by department
🎯 Business Results

The final dashboard provides several important observations.

Overall Business Performance

The dataset contains approximately:

33.05M Total Revenue
3.97M Total Profit
66K Total Orders
21K Total Customers
384K Total Quantity
Customer Insights

The Consumer segment represents the largest customer segment and also generates the highest revenue among the three customer segments.

Customer concentration is particularly strong in the United States, with additional customer presence in Puerto Rico.

Product Insights

The product portfolio contains:

118 Products
51 Categories

Revenue is concentrated in a relatively small number of departments and products.

The Top 10 Products analysis highlights the products contributing the most revenue.

Salesman Insights

The Salesman analysis shows differences in performance across sales representatives.

The Top 10 Salesmen by Revenue and Top 10 Salesmen by Profit provide two different views of sales performance, allowing high-revenue and high-profit performers to be identified separately.

The Commission Rate vs Revenue scatter plot provides an additional analytical perspective on the relationship between salesperson compensation and revenue.

Logistics Insights

One of the most important findings is the high Late Delivery Rate, approximately:

54.82%

The dashboard also shows noticeable differences in late-delivery performance between shipping modes.

The Actual vs Scheduled Shipping analysis helps identify where actual shipping time exceeds planned shipping time.

🔐 Data Privacy

Sensitive information was excluded from the analytical Gold layer where it did not provide business value.

Excluded fields include:

Customers
Email
Password
ZIP Code
Salesmen
Email

The objective was to keep the analytical model focused on business-relevant attributes while reducing unnecessary sensitive data exposure.

🧠 Key Data Modeling Decisions
1. Star Schema

A star schema was selected to simplify Power BI analysis and improve analytical usability.

2. Order Item Grain

The FactOrders table operates at the order-item level.

Therefore:
```text
Order_Id ≠ Order_Item_Id ≠ Product_Card_Id
```
An order can contain multiple order items, while each order item is associated with a product.

3. Separate Date Dimensions

Order dates and shipping dates were separated into:
```text
DimOrderDate
DimShippingDate
```
This allows independent time-based analysis of orders and shipping operations.

4. Product Dimension

Product, Category, and Department information were kept together in DimProducts to keep the analytical model simple and practical for the dashboard requirements.

📁 Suggested Repository Structure
```text
SupplyChainDWH/
│
├── README.md
│
├── SQL/
│   └── SQL QUERIES.sql
│
├── PowerBI/
│   └── SupplyChainDWH.pbix
│
├── Data/
│   └── Source Files
│
└── Screenshots/
    ├── Overview.png
    ├── Customer.png
    ├── Products.png
    ├── Sales_Logistics.png
    └── Salesman.png
```
🚀 Project Workflow

The project workflow can be summarized as:
```text
1. Load raw source data
        ↓
2. Create Bronze layer
        ↓
3. Clean and standardize data
        ↓
4. Create Silver layer
        ↓
5. Validate row counts and data consistency
        ↓
6. Build Gold dimensional model
        ↓
7. Create dimensions and fact table
        ↓
8. Connect Gold layer to Power BI
        ↓
9. Create DAX measures
        ↓
10. Build analytical dashboard
        ↓
11. Extract business insights
```
📌 Final Outcome

The final solution transforms raw supply chain data into a structured analytical platform that can be used to answer business questions across:

Customers → Products → Sales → Salesmen → Logistics

The combination of SQL Server, dimensional modeling, DAX, and Power BI provides an end-to-end BI solution from raw data ingestion to business insights.

👨‍💻 Author

Mohammed Mahfouz

Data Analyst | SQL | Power BI | Data Warehousing
