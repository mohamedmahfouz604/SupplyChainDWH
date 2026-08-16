USE master;
GO

CREATE DATABASE SupplyChainDWH;
GO

USE SupplyChainDWH;
GO

CREATE SCHEMA Bronze;
GO

CREATE SCHEMA Silver;
GO

CREATE SCHEMA Gold;
GO

USE SupplyChainDWH;
GO
--Bronze layer--

-- Customer --
select *
from Bronze.Customers;
GO


SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN Customer_Id IS NULL THEN 1 ELSE 0 END) AS Customer_Id_NULL,
    SUM(CASE WHEN Customer_Fname IS NULL THEN 1 ELSE 0 END) AS Customer_Fname_NULL,
    SUM(CASE WHEN Customer_Lname IS NULL THEN 1 ELSE 0 END) AS Customer_Lname_NULL,
    SUM(CASE WHEN Customer_Email IS NULL THEN 1 ELSE 0 END) AS Customer_Email_NULL,
    SUM(CASE WHEN Customer_Password IS NULL THEN 1 ELSE 0 END) AS Customer_Password_NULL,
    SUM(CASE WHEN Customer_Segment IS NULL THEN 1 ELSE 0 END) AS Customer_Segment_NULL,
    SUM(CASE WHEN Customer_City IS NULL THEN 1 ELSE 0 END) AS Customer_City_NULL,
    SUM(CASE WHEN Customer_State IS NULL THEN 1 ELSE 0 END) AS Customer_State_NULL,
    SUM(CASE WHEN Customer_Street IS NULL THEN 1 ELSE 0 END) AS Customer_Street_NULL,
    SUM(CASE WHEN Customer_Zipcode IS NULL THEN 1 ELSE 0 END) AS Customer_Zipcode_NULL,
    SUM(CASE WHEN Customer_Country IS NULL THEN 1 ELSE 0 END) AS Customer_Country_NULL,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Latitude_NULL,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Longitude_NULL,
    SUM(CASE WHEN Customer_Birth_Date IS NULL THEN 1 ELSE 0 END) AS Customer_Birth_Date_NULL

FROM Bronze.Customers;
GO
--=====================================--
USE SupplyChainDWH;
GO

SELECT
    Customer_Id,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Customers
GROUP BY Customer_Id
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;
--=====================================--
SELECT
    Customer_Id,
    Customer_Fname,
    Customer_Lname,
    Customer_Email,
    Customer_Password,
    Customer_Segment,
    Customer_City,
    Customer_State,
    Customer_Street,
    Customer_Zipcode,
    Customer_Country,
    Latitude,
    Longitude,
    Customer_Birth_Date,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Customers
GROUP BY
    Customer_Id,
    Customer_Fname,
    Customer_Lname,
    Customer_Email,
    Customer_Password,
    Customer_Segment,
    Customer_City,
    Customer_State,
    Customer_Street,
    Customer_Zipcode,
    Customer_Country,
    Latitude,
    Longitude,
    Customer_Birth_Date
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;


-- 1:مش هناخد الايميل و الباسورد معانا فى الجولد
-- ORDERS --
select *
from [Bronze].[Orders];
/*
1- order id -> int 
2- order item id -> int
3- عايزين نثبت ال Delivery_Status عشان فيه كلام كله كابتال و كل ال Status ثابته
4- نفس الكلام اللى فى رقم ثلاثه هنعمله مع ال Type
5- [Days_for_shipping_real] ->int
6- [Days_for_shipment_scheduled] ->int
7- Benefit_per_order -> float
8- Late_delivery_risk -> int
9- [Market]نفس اللى عملناه فى 3 و 4
10- [Order_State]نفس اللى عملناه فى 3 و 4
11- [Order_Status]نفس اللى عملناه فى 3 و 4
12- [Order_Zipcode] معالجه ال nulls
13- [Shipping_Mode] نفس اللى عملناه فى 3 و 4
14- [Order_Item_Discount] -> float
15- [Order_Item_Profit_Ratio] -> float
16- [Order_Item_Quantity] -> int
*/
USE SupplyChainDWH;
GO

DECLARE @SQL NVARCHAR(MAX) = N'';

SELECT @SQL = @SQL +
'
SELECT
    ''' + COLUMN_NAME + ''' AS Column_Name,
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN [' + COLUMN_NAME + '] IS NULL THEN 1 ELSE 0 END) AS Null_Rows,
    SUM(
        CASE
            WHEN [' + COLUMN_NAME + '] IS NOT NULL
             AND LTRIM(RTRIM(CONVERT(NVARCHAR(MAX), [' + COLUMN_NAME + ']))) = ''''
            THEN 1
            ELSE 0
        END
    ) AS Blank_Rows
FROM Bronze.Orders
UNION ALL
'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Bronze'
  AND TABLE_NAME = 'Orders';

SET @SQL = LEFT(@SQL, LEN(@SQL) - LEN('UNION ALL') - 1);

EXEC sp_executesql @SQL;
GO

-- معالجه ال nulls فى ال [Order_Zipcode]--

USE SupplyChainDWH;
GO

SELECT
    Order_Item_Id,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Orders
GROUP BY Order_Item_Id
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(Order_Item_Id) AS Non_Null_Order_Item_Id,
    COUNT(*) - COUNT(Order_Item_Id) AS Null_Order_Item_Id
FROM Bronze.Orders;

SELECT
    Order_Id,
    COUNT(*) AS Item_Count
FROM Bronze.Orders
GROUP BY Order_Id
ORDER BY Item_Count DESC;

SELECT
    Order_Id,
    Order_Item_Id,
    Customer_Id,
    Product_Card_Id,
    Type,
    Days_for_shipping_real,
    Days_for_shipment_scheduled,
    Benefit_per_order,
    Delivery_Status,
    Late_delivery_risk,
    Market,
    Order_Region,
    Order_State,
    Order_Status,
    Order_Zipcode,
    order_date_DateOrders,
    shipping_date_DateOrders,
    Shipping_Mode,
    Order_Item_Discount,
    Order_Item_Profit_Ratio,
    Order_Item_Quantity,
    Order_Item_Total,
    salesman_id,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Orders
GROUP BY
    Order_Id,
    Order_Item_Id,
    Customer_Id,
    Product_Card_Id,
    Type,
    Days_for_shipping_real,
    Days_for_shipment_scheduled,
    Benefit_per_order,
    Delivery_Status,
    Late_delivery_risk,
    Market,
    Order_Region,
    Order_State,
    Order_Status,
    Order_Zipcode,
    order_date_DateOrders,
    shipping_date_DateOrders,
    Shipping_Mode,
    Order_Item_Discount,
    Order_Item_Profit_Ratio,
    Order_Item_Quantity,
    Order_Item_Total,
    salesman_id
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;

-- products --
select *
from Bronze.Products;

/*
1- [Product_Status] -> int
2- fill nulls in [Product_Description] with unknown or drop it becuase there is no data in this column
*/

SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN Product_Card_Id IS NULL THEN 1 ELSE 0 END) AS Product_Card_Id_NULL,
    SUM(CASE WHEN Product_Name IS NULL THEN 1 ELSE 0 END) AS Product_Name_NULL,
    SUM(CASE WHEN Product_Price IS NULL THEN 1 ELSE 0 END) AS Product_Price_NULL,
    SUM(CASE WHEN Product_Status IS NULL THEN 1 ELSE 0 END) AS Product_Status_NULL,
    SUM(CASE WHEN Product_Description IS NULL THEN 1 ELSE 0 END) AS Product_Description_NULL,
    SUM(CASE WHEN Category_Id IS NULL THEN 1 ELSE 0 END) AS Category_Id_NULL,
    SUM(CASE WHEN Category_Name IS NULL THEN 1 ELSE 0 END) AS Category_Name_NULL,
    SUM(CASE WHEN Department_Id IS NULL THEN 1 ELSE 0 END) AS Department_Id_NULL,
    SUM(CASE WHEN Department_Name IS NULL THEN 1 ELSE 0 END) AS Department_Name_NULL

FROM Bronze.Products;
GO

SELECT
    Product_Card_Id,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Products
GROUP BY Product_Card_Id
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;

SELECT
    Product_Card_Id,
    Product_Name,
    Product_Price,
    Product_Status,
    Product_Description,
    Category_Id,
    Category_Name,
    Department_Id,
    Department_Name,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Products
GROUP BY
    Product_Card_Id,
    Product_Name,
    Product_Price,
    Product_Status,
    Product_Description,
    Category_Id,
    Category_Name,
    Department_Id,
    Department_Name
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;

-- sales man --

select *
from Bronze.Salesman;

/*
[Salesman_Id] -> int
*/

SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN Salesman_Id IS NULL THEN 1 ELSE 0 END) AS Salesman_Id_NULL,
    SUM(CASE WHEN Salesman_Fname IS NULL THEN 1 ELSE 0 END) AS Salesman_Fname_NULL,
    SUM(CASE WHEN Salesman_Lname IS NULL THEN 1 ELSE 0 END) AS Salesman_Lname_NULL,
    SUM(CASE WHEN Salesman_Email IS NULL THEN 1 ELSE 0 END) AS Salesman_Email_NULL,
    SUM(CASE WHEN Market IS NULL THEN 1 ELSE 0 END) AS Market_NULL,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS Region_NULL,
    SUM(CASE WHEN Hire_Date IS NULL THEN 1 ELSE 0 END) AS Hire_Date_NULL,
    SUM(CASE WHEN Commission_Rate IS NULL THEN 1 ELSE 0 END) AS Commission_Rate_NULL

FROM Bronze.Salesman;
GO

SELECT
    Salesman_Id,
    COUNT(*) AS Duplicate_Count
FROM Bronze.Salesman
GROUP BY Salesman_Id
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;


-- Silver layer--
-- customer --
SELECT
    Customer_Id,
    LTRIM(RTRIM(Customer_Fname))      AS Customer_Fname,
    LTRIM(RTRIM(Customer_Lname))      AS Customer_Lname,
    LTRIM(RTRIM(Customer_Email))      AS Customer_Email,
    Customer_Password,
    LTRIM(RTRIM(Customer_Segment))    AS Customer_Segment,
    LTRIM(RTRIM(Customer_City))       AS Customer_City,
    LTRIM(RTRIM(Customer_State))      AS Customer_State,
    LTRIM(RTRIM(Customer_Street))     AS Customer_Street,
    Customer_Zipcode,
    LTRIM(RTRIM(Customer_Country))    AS Customer_Country,
    Latitude,
    Longitude,
    CAST(Customer_Birth_Date AS DATE) AS Customer_Birth_Date

INTO Silver.Customers

FROM Bronze.Customers;
GO

SELECT
    (SELECT COUNT(*) FROM Bronze.Customers) AS Bronze_Count,
    (SELECT COUNT(*) FROM Silver.Customers) AS Silver_Count;

-- orders --

SELECT
    TRY_CAST(Order_Id AS INT) AS Order_Id,
    TRY_CAST(Order_Item_Id AS INT) AS Order_Item_Id,
    TRY_CAST(Customer_Id AS INT) AS Customer_Id,
    TRY_CAST(Product_Card_Id AS INT) AS Product_Card_Id,

    LTRIM(RTRIM(Type)) AS Type,

    TRY_CAST(Days_for_shipping_real AS INT)
        AS Days_for_shipping_real,

    TRY_CAST(Days_for_shipment_scheduled AS INT)
        AS Days_for_shipment_scheduled,

    TRY_CAST(Benefit_per_order AS FLOAT)
        AS Benefit_per_order,

    CASE
        WHEN LOWER(REPLACE(LTRIM(RTRIM(Delivery_Status)), '  ', ' '))
            = 'advance shipping'
            THEN 'Advance shipping'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Delivery_Status)), '  ', ' '))
            = 'late delivery'
            THEN 'Late delivery'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Delivery_Status)), '  ', ' '))
            = 'shipping canceled'
            THEN 'Shipping canceled'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Delivery_Status)), '  ', ' '))
            = 'shipping on time'
            THEN 'Shipping on time'

        ELSE LTRIM(RTRIM(Delivery_Status))
    END AS Delivery_Status,

    TRY_CAST(Late_delivery_risk AS INT)
        AS Late_delivery_risk,

    CASE
        WHEN LOWER(REPLACE(LTRIM(RTRIM(Market)), '  ', ' '))
            = 'pacific asia'
            THEN 'Pacific Asia'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Market)), '  ', ' '))
            IN ('us & canada', 'us and canada', 'usca')
            THEN 'USCA'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Market)), '  ', ' '))
            IN ('latin america', 'latam')
            THEN 'LATAM'

        WHEN LOWER(LTRIM(RTRIM(Market))) = 'africa'
            THEN 'Africa'

        WHEN LOWER(LTRIM(RTRIM(Market))) = 'europe'
            THEN 'Europe'

        ELSE LTRIM(RTRIM(Market))
    END AS Market,

    LTRIM(RTRIM(Order_Region)) AS Order_Region,

    LTRIM(RTRIM(REPLACE(Order_State, '  ', ' ')))
        AS Order_State,

    LTRIM(RTRIM(Order_Status)) AS Order_Status,

    NULLIF(
        LTRIM(RTRIM(Order_Zipcode)),
        'Unknown'
    ) AS Order_Zipcode,

    TRY_CAST(order_date_DateOrders AS DATE)
        AS order_date_DateOrders,

    TRY_CAST(shipping_date_DateOrders AS DATE)
        AS shipping_date_DateOrders,

    CASE
        WHEN LOWER(REPLACE(LTRIM(RTRIM(Shipping_Mode)), '  ', ' '))
            IN ('standard', 'standard class', 'std class')
            THEN 'Standard Class'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Shipping_Mode)), '  ', ' '))
            IN ('second class', '2nd class')
            THEN 'Second Class'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Shipping_Mode)), '  ', ' '))
            IN ('first class', '1st class')
            THEN 'First Class'

        WHEN LOWER(REPLACE(LTRIM(RTRIM(Shipping_Mode)), '  ', ' '))
            IN ('same day', 'same-day')
            THEN 'Same Day'

        ELSE LTRIM(RTRIM(Shipping_Mode))
    END AS Shipping_Mode,

    TRY_CAST(Order_Item_Discount AS FLOAT)
        AS Order_Item_Discount,

    TRY_CAST(Order_Item_Profit_Ratio AS FLOAT)
        AS Order_Item_Profit_Ratio,

    TRY_CAST(Order_Item_Quantity AS INT)
        AS Order_Item_Quantity,

    TRY_CAST(Order_Item_Total AS FLOAT)
        AS Order_Item_Total,

    TRY_CAST(salesman_id AS INT)
        AS salesman_id

INTO Silver.Orders
FROM Bronze.Orders;
GO

UPDATE O
SET O.Order_Zipcode = C.Customer_Zipcode
FROM Silver.Orders O
INNER JOIN Silver.Customers C
    ON O.Customer_Id = C.Customer_Id
WHERE O.Order_Zipcode IS NULL
  AND C.Customer_Zipcode IS NOT NULL;

SELECT
    (SELECT COUNT(*) FROM Bronze.Orders) AS Bronze_Count,
    (SELECT COUNT(*) FROM Silver.Orders) AS Silver_Count,
    (SELECT COUNT(*) FROM Bronze.Orders)
    -
    (SELECT COUNT(*) FROM Silver.Orders) AS Difference;


-- products--
DROP TABLE IF EXISTS Silver.Products;

SELECT
    Product_Card_Id,
    Product_Name,
    Product_Price,
    TRY_CAST(Product_Status AS INT) AS Product_Status,
    COALESCE(
        NULLIF(LTRIM(RTRIM(Product_Description)), ''),
        'Unknown'
    ) AS Product_Description,
    Category_Id,
    Category_Name,
    Department_Id,
    Department_Name
INTO Silver.Products
FROM Bronze.Products;

SELECT *
FROM Silver.Products;

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Silver'
  AND TABLE_NAME = 'Products';
-- salse man
SELECT
    TRY_CAST(Salesman_Id AS INT) AS Salesman_Id,
    Salesman_Fname,
    Salesman_Lname,
    Salesman_Email,
    Market,
    Region,
    Hire_Date,
    Commission_Rate
INTO Silver.Salesman
FROM Bronze.Salesman;


-- gold layer --

SELECT
    Customer_Id,

    CONCAT(
        LTRIM(RTRIM(Customer_Fname)),
        ' ',
        LTRIM(RTRIM(Customer_Lname))
    ) AS Customer_Full_Name,

    Customer_Segment,
    Customer_City,
    Customer_State,
    Customer_Street,
    Customer_Country,
    Latitude,
    Longitude,
    Customer_Birth_Date

INTO Gold.DimCustomers

FROM Silver.Customers;


SELECT
    Product_Card_Id,
    Product_Name,
    Product_Price,
    Product_Status,
    Product_Description,
    Category_Id,
    Category_Name,
    Department_Id,
    Department_Name

INTO Gold.DimProducts

FROM Silver.Products;

SELECT
    Salesman_Id,

    CONCAT(
        LTRIM(RTRIM(Salesman_Fname)),
        ' ',
        LTRIM(RTRIM(Salesman_Lname))
    ) AS Salesman_Full_Name,

    Market,
    Region,
    Hire_Date,
    Commission_Rate

INTO Gold.DimSalesman

FROM Silver.Salesman;

SELECT DISTINCT

    CONVERT(
        INT,
        CONVERT(
            CHAR(8),
            TRY_CAST(order_date_DateOrders AS DATE),
            112
        )
    ) AS Date_Key,

    TRY_CAST(order_date_DateOrders AS DATE) AS Full_Date,

    DAY(
        TRY_CAST(order_date_DateOrders AS DATE)
    ) AS Day,

    MONTH(
        TRY_CAST(order_date_DateOrders AS DATE)
    ) AS Month,

    DATENAME(
        MONTH,
        TRY_CAST(order_date_DateOrders AS DATE)
    ) AS Month_Name,

    DATEPART(
        QUARTER,
        TRY_CAST(order_date_DateOrders AS DATE)
    ) AS Quarter,

    YEAR(
        TRY_CAST(order_date_DateOrders AS DATE)
    ) AS Year

INTO Gold.DimOrderDate

FROM Silver.Orders

WHERE TRY_CAST(order_date_DateOrders AS DATE) IS NOT NULL;

SELECT DISTINCT

    CONVERT(
        INT,
        CONVERT(
            CHAR(8),
            TRY_CAST(shipping_date_DateOrders AS DATE),
            112
        )
    ) AS Date_Key,

    TRY_CAST(shipping_date_DateOrders AS DATE) AS Full_Date,

    DAY(
        TRY_CAST(shipping_date_DateOrders AS DATE)
    ) AS Day,

    MONTH(
        TRY_CAST(shipping_date_DateOrders AS DATE)
    ) AS Month,

    DATENAME(
        MONTH,
        TRY_CAST(shipping_date_DateOrders AS DATE)
    ) AS Month_Name,

    DATEPART(
        QUARTER,
        TRY_CAST(shipping_date_DateOrders AS DATE)
    ) AS Quarter,

    YEAR(
        TRY_CAST(shipping_date_DateOrders AS DATE)
    ) AS Year

INTO Gold.DimShippingDate

FROM Silver.Orders

WHERE TRY_CAST(shipping_date_DateOrders AS DATE) IS NOT NULL;

SELECT

    Order_Id,
    Order_Item_Id,

    Customer_Id,
    Product_Card_Id,
    Salesman_Id,

    CONVERT(
        INT,
        CONVERT(
            CHAR(8),
            TRY_CAST(order_date_DateOrders AS DATE),
            112
        )
    ) AS Order_Date_Key,

    CONVERT(
        INT,
        CONVERT(
            CHAR(8),
            TRY_CAST(shipping_date_DateOrders AS DATE),
            112
        )
    ) AS Shipping_Date_Key,

    Type,

    Days_for_shipping_real,
    Days_for_shipment_scheduled,

    Benefit_per_order,

    Delivery_Status,
    Late_delivery_risk,

    Market,
    Order_Region,
    Order_State,
    Order_Status,

    Shipping_Mode,

    Order_Item_Discount,
    Order_Item_Profit_Ratio,
    Order_Item_Quantity,
    Order_Item_Total

INTO Gold.FactOrders

FROM Silver.Orders;

