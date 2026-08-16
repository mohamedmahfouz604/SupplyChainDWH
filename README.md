# 📊 SupplyChainDWH – Supply Chain Analytics Dashboard

## 📌 Project Overview

SupplyChainDWH is an end-to-end Business Intelligence project developed to analyze Supply Chain data and transform it into meaningful and interactive business insights.

The project combines:

- SQL
- Data Cleaning
- Data Transformation
- Data Warehouse Modeling
- Dimensional Modeling
- DAX
- Power BI
- Data Visualization
- Business Analysis

The final result is an interactive Power BI dashboard covering five major areas:

1. Overview
2. Customer Analysis
3. Products Analysis
4. Sales & Logistics
5. Salesman Analysis

This project was developed as the **final project during my training journey**.

---

# 🎯 Project Objective

The main objective of the project was to transform raw Supply Chain data into a structured analytical solution that can help answer important business questions.

The analysis focuses on:

- Overall business performance
- Revenue and profit
- Customer behavior
- Product performance
- Market performance
- Logistics and delivery performance
- Salesman performance

The project also focuses on going beyond visualization by investigating unusual patterns in the data and understanding what is happening behind the KPIs.

---

# 🏗️ Data Warehouse Architecture

The project follows a layered Data Warehouse architecture:

```text
Raw Data
   ↓
Bronze Layer
   ↓
Silver Layer
   ↓
Gold Layer
   ↓
Power BI
```
Bronze Layer

The Bronze layer stores the source data in its raw form.

The main purpose is to preserve the original source data before applying transformations.

Silver Layer

The Silver layer is responsible for data preparation and cleaning.

Main transformations include:

Data type conversion
Trimming spaces
Handling missing values
Removing duplicates
Standardizing values
Cleaning categorical fields
Preparing data for dimensional modeling

Examples of standardized fields include:

Delivery Status
Shipping Mode
Market
Region
Customer Segment
Gold Layer

The Gold layer contains the final analytical model used by Power BI.

The model follows a dimensional modeling approach using a Star Schema.

Fact Table
Gold FactOrders
Dimension Tables
Gold DimCustomers
Gold DimProducts
Gold DimSalesman
Gold DimOrderDate
Gold DimShippingDate
⭐ Star Schema

The main structure can be summarized as:
```text
                  DimCustomers
                       |
                       |
DimOrderDate ---- FactOrders ---- DimProducts
                       |
                       |
                 DimSalesman
                       |
                       |
                DimShippingDate
```
The Fact table contains order-level and order-item-level transactional information used for analysis.

📊 Power BI Dashboard

The Power BI report contains five main analytical pages.

1. 📈 Overview

The Overview page provides a high-level view of the overall business.
```text
| KPI                |  Value |
| ------------------ | -----: |
| Total Revenue      | 33.05M |
| Total Profit       |  3.97M |
| Total Orders       |    66K |
| Total Customers    |    21K |
| Late Delivery Rate | 54.82% |
```
Main Visuals
Revenue Trend
Revenue by Market
Delivery Status
Time Filter

The purpose of this page is to provide a quick summary before moving into detailed analysis.

2. 👥 Customer Analysis

The Customer page focuses on customer distribution and contribution to revenue.

Main Analysis
Customer Distribution by Segment
Revenue by Customer Segment
Customers by Country
Top States
Customer Geographic Distribution
Customer Segment Distribution
```text
| Segment     |  Share |
| ----------- | -----: |
| Consumer    | 51.79% |
| Corporate   | 30.21% |
| Home Office | 18.00% |
```
The Consumer segment represents the largest customer group.

It is also the largest contributor to total revenue.

Key Observation

The analysis shows that customer activity is concentrated in specific segments and geographic areas.

This allows the business to understand where its customer base is strongest and which customer groups contribute most to revenue.

3. 📦 Products Analysis

The Products page focuses on product portfolio and revenue contribution.

KPIs
```text
| KPI                 |  Value |
| ------------------- | -----: |
| Total Products      |    118 |
| Total Categories    |     51 |
| Total Quantity      |   384K |
| Average Order Value | 502.71 |
```
Main Visuals
Revenue by Department
Top 10 Products by Revenue
Revenue by Category
Department Performance

The Fan Shop department is the highest revenue-generating department in the displayed analysis.

Other major departments include:

Apparel
Golf
Footwear
Category Performance

Fishing is one of the strongest revenue-generating categories in the analysis.

The Top 10 Products visualization also shows that revenue is concentrated among a smaller group of products.

4. 🚚 Sales & Logistics

The Sales & Logistics page combines sales performance with delivery and shipping analysis.

KPIs
```text
| KPI                |  Value |
| ------------------ | -----: |
| Total Revenue      | 33.05M |
| Total Profit       |  3.97M |
| Total Orders       |    66K |
| Late Delivery Rate | 54.82% |
```
Main Visuals
Revenue by Market
Revenue Trend
Late Delivery Rate by Shipping Mode
Actual vs Scheduled Shipping Days
🌍 Revenue by Market

The displayed revenue distribution is:
```text
| Market       | Revenue Share |
| ------------ | ------------: |
| Europe       |        29.55% |
| LATAM        |        27.94% |
| Pacific Asia |        22.49% |
| USCA         |        13.78% |
| Africa       |         6.24% |
```
Key Finding

Europe is the largest revenue-generating market.

Europe, LATAM, and Pacific Asia together account for approximately 80% of total revenue.

🚚 Logistics Analysis

The overall Late Delivery Rate is:

54.82%

This means that more than half of the analyzed order items are associated with a late-delivery risk.

Late Delivery Rate by Shipping Mode
```text
| Shipping Mode  | Late Delivery Rate |
| -------------- | -----------------: |
| First Class    |              95.3% |
| Second Class   |              76.6% |
| Same Day       |              45.7% |
| Standard Class |              38.1% |
```
Key Finding

First Class has the highest late-delivery rate among the displayed shipping modes, while Standard Class has the lowest.

This makes shipping mode an important factor to investigate when evaluating delivery performance.

⏱️ Actual vs Scheduled Shipping

The dashboard also compares actual shipping duration with the scheduled duration.
```text
| Shipping Mode  |    Actual | Scheduled |
| -------------- | --------: | --------: |
| Standard Class |   ~4 days |   ~4 days |
| Second Class   |   ~4 days |   ~2 days |
| First Class    |   ~2 days |    ~1 day |
| Same Day       | ~0.48 day |     0 day |
```
Key Finding

Second Class shows a noticeable gap between actual and scheduled shipping duration.

This suggests that delivery performance should not only be evaluated using overall late-delivery percentages, but also by comparing actual performance against the expected shipping duration.

📉 Revenue Drop Investigation

One of the most important findings from the analysis was the sudden decline in Revenue toward the end of the available timeline.

At first glance, the Revenue Trend could suggest a significant decline in business performance.

However, investigating the underlying order data reveals an important pattern.

Revenue and Order Trend

Revenue remains relatively stable through September 2017:

July 2017 → ~992K
August 2017 → ~997K
September 2017 → ~1.027M

Then Revenue begins to decline:

October 2017 → ~966K
November 2017 → ~563K
December 2017 → ~453K
January 2018 → ~298K

However, the number of orders does not decline in the same way.

Approximate orders:

July → 1,776
August → 1,768
September → 1,723
October → 2,101
November → 2,055
December → 2,124
January → 2,123

This is a critical observation.

What changed?

The average number of items per order changes significantly.
```text
| Period         | Approx. Items / Order |
| -------------- | --------------------: |
| July 2017      |                    ~3 |
| August 2017    |                    ~3 |
| September 2017 |                    ~3 |
| October 2017   |                    ~1 |
| November 2017  |                    ~1 |
| December 2017  |                    ~1 |
| January 2018   |                    ~1 |
```
At the same time, the number of distinct products appearing in transactions decreases significantly.

For example:

September 2017 → ~53 products
October 2017 → ~20 products
November 2017 → ~8 products
December 2017 → ~14 products
January 2018 → ~10 products
Conclusion

The Revenue decline should not automatically be interpreted as a real business decline.

The combination of:

Stable/increasing order volume
Lower items per order
Lower product coverage
Significant revenue decline

strongly suggests a potential change in data completeness or transaction granularity toward the end of the dataset.

Therefore, the Revenue Drop is treated as a data-quality/data-coverage finding that requires further validation, rather than a confirmed business performance decline.

This investigation was an important part of the project because it demonstrates the difference between simply identifying an anomaly and actually investigating the data behind it.

5. 👨‍💼 Salesman Analysis

The Salesman page focuses on sales team performance.

KPIs
```text
| KPI                          |  Value |
| ---------------------------- | -----: |
| Total Salesmen               |    603 |
| Average Revenue per Salesman | 54.82K |
| Average Profit per Salesman  |  6.58K |
```
Main Visuals
Top 10 Salesmen by Revenue
Top 10 Salesmen by Profit
Revenue by Region
High Commission Rate Salesmen
Commission Rate vs Revenue
💡 Commission Rate vs Revenue

A Scatter Chart was created to investigate the following business question:

Does a higher commission rate lead to higher revenue?

The analysis does not show a strong linear relationship between Commission Rate and Revenue.

The approximate correlation is close to zero:

r ≈ -0.03

Conclusion

Higher commission rates do not necessarily translate into higher revenue.

This suggests that salesperson performance is likely influenced by factors beyond commission rate alone.

🧮 Main DAX Measures

The dashboard uses DAX measures to calculate the main business KPIs.

Total Revenue
```text
Total Revenue =
SUM('Gold FactOrders'[Order_Item_Total])
Total Orders
```text
Total Orders =
DISTINCTCOUNT('Gold FactOrders'[Order_Id])
```
Total Customers
```text
Total Customers =
DISTINCTCOUNT('Gold FactOrders'[Customer_Id])
```
Total Quantity
```text
Total Quantity =
SUM('Gold FactOrders'[Order_Item_Quantity])
```
Average Order Value
```text
Average Order Value =
DIVIDE(
    [Total Revenue],
    [Total Orders],
    0
)
```
Late Delivery Rate
```text
Late Delivery Rate =
DIVIDE(
    CALCULATE(
        [Total Orders],
        'Gold FactOrders'[Delivery_Status] = "Late delivery"
    ),
    [Total Orders],
    0
)
```
🛠️ Tools & Technologies
SQL Server
Power BI Desktop
DAX
Power Query
Data Modeling
Data Visualization
Business Intelligence
Supply Chain Analytics
🎯 Key Insights Summary

The main findings from the project include:

Sales
Total Revenue: 33.05M
Total Profit: 3.97M
Total Orders: 66K
Average Order Value: 502.71
Customers
Total Customers: 21K
Consumer is the largest customer segment.
Customer activity is concentrated in specific geographic areas.
Products
118 Products
51 Categories
384K Total Quantity
Revenue is concentrated among a smaller group of products.
Fan Shop is the highest revenue-generating department in the displayed analysis.
Fishing is one of the strongest categories.
Markets
Europe is the largest revenue-generating market.
Europe, LATAM, and Pacific Asia represent approximately 80% of revenue combined.
Logistics
Late Delivery Rate: 54.82%
First Class has the highest late-delivery rate.
Standard Class has the lowest displayed late-delivery rate.
Second Class shows a noticeable actual-vs-scheduled shipping gap.
Salesmen
603 Salesmen
Significant variation exists between salesmen in Revenue and Profit.
Commission Rate does not show a strong relationship with Revenue.
Data Quality

The sharp Revenue decline near the end of the timeline is accompanied by stable/increasing order volume but significantly fewer items per order and fewer distinct products.

This suggests that the decline may be related to data completeness or transaction-grain changes, and therefore requires validation before being interpreted as a real business decline.

📂 Dashboard Pages
```text
| Page              | Purpose                               |
| ----------------- | ------------------------------------- |
| Overview          | Overall business performance          |
| Customer Analysis | Customer segmentation and geography   |
| Products Analysis | Product and category performance      |
| Sales & Logistics | Sales, markets, shipping and delivery |
| Salesman Analysis | Sales team performance                |
```
🎓 Training Project

This project represents the final project of my training journey.

It allowed me to combine the skills I developed during the training into one complete Business Intelligence workflow:
```text
Raw Data
    ↓
Bronze Layer
    ↓
Silver Layer
    ↓
Gold Layer
    ↓
Data Modeling
    ↓
DAX
    ↓
Power BI Dashboard
    ↓
Business Insights
```
The main lesson from the project was that effective data analysis is not only about creating visualizations.

It is about:

Finding the pattern → Asking the right question → Investigating the data → Validating the finding → Communicating the insight.

👤 Author

Mohamed Mahfouz

Data Analytics | Power BI | SQL | DAX | Business Intelligence

⭐ Project Highlights
End-to-end Supply Chain Analytics
SQL Data Warehouse
Bronze / Silver / Gold Architecture
Star Schema
Power BI Dashboard
DAX Measures
Customer Analysis
Product Analysis
Sales & Logistics Analysis
Salesman Performance Analysis
Revenue Trend Investigation
Data Quality Investigation
Business Storytelling
