-- PART B: CLINIC SYSTEM ANALYSIS QUERIES

USE clinic_db;

-- Q1: Total revenue by sales channel
SELECT
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY sales_channel;


-- Q2: Total revenue by clinic in March 2021
SELECT
    c.cid,
    c.clinic_name,
    SUM(cs.amount) AS march_revenue
FROM clinic_sales cs
JOIN clinics c ON cs.cid = c.cid
WHERE
    MONTH(cs.datetime) = 3
    AND YEAR(cs.datetime) = 2021
GROUP BY
    c.cid,
    c.clinic_name
ORDER BY
    march_revenue DESC;


-- Q3: Profit / Loss per clinic in March 2021
WITH revenue AS (
    SELECT
        cid,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE
        MONTH(datetime) = 3
        AND YEAR(datetime) = 2021
    GROUP BY cid
),
expense AS (
    SELECT
        cid,
        SUM(amount) AS expense
    FROM expenses
    WHERE
        MONTH(datetime) = 3
        AND YEAR(datetime) = 2021
    GROUP BY cid
)
SELECT
    c.cid,
    c.clinic_name,
    COALESCE(r.revenue, 0) AS revenue,
    COALESCE(e.expense, 0) AS expense,
    COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
FROM clinics c
LEFT JOIN revenue r ON c.cid = r.cid
LEFT JOIN expense e ON c.cid = e.cid
ORDER BY profit DESC;


-- Q4: Highest profit clinic in each state (for March 2021)
WITH revenue AS (
    SELECT
        cid,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE
        MONTH(datetime) = 3
        AND YEAR(datetime) = 2021
    GROUP BY cid
),
expense AS (
    SELECT
        cid,
        SUM(amount) AS expense
    FROM expenses
    WHERE
        MONTH(datetime) = 3
        AND YEAR(datetime) = 2021
    GROUP BY cid
),
clinic_profit AS (
    SELECT
        c.state,
        c.cid,
        c.clinic_name,
        COALESCE(r.revenue, 0) AS revenue,
        COALESCE(e.expense, 0) AS expense,
        COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
    FROM clinics c
    LEFT JOIN revenue r ON c.cid = r.cid
    LEFT JOIN expense e ON c.cid = e.cid
),
ranked AS (
    SELECT
        state,
        cid,
        clinic_name,
        revenue,
        expense,
        profit,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit DESC) AS rnk_desc
    FROM clinic_profit
)
SELECT
    state,
    cid,
    clinic_name,
    revenue,
    expense,
    profit
FROM ranked
WHERE rnk_desc = 1
ORDER BY state;


-- Q5: Second lowest profit clinic in each state (for March 2021)
WITH revenue AS (
    SELECT
        cid,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE
        MONTH(datetime) = 3
        AND YEAR(datetime) = 2021
    GROUP BY cid
),
expense AS (
    SELECT
        cid,
        SUM(amount) AS expense
    FROM expenses
    WHERE
        MONTH(datetime) = 3
        AND YEAR(datetime) = 2021
    GROUP BY cid
),
clinic_profit AS (
    SELECT
        c.state,
        c.cid,
        c.clinic_name,
        COALESCE(r.revenue, 0) AS revenue,
        COALESCE(e.expense, 0) AS expense,
        COALESCE(r.revenue, 0) - COALESCE(e.expense, 0) AS profit
    FROM clinics c
    LEFT JOIN revenue r ON c.cid = r.cid
    LEFT JOIN expense e ON c.cid = e.cid
),
ranked AS (
    SELECT
        state,
        cid,
        clinic_name,
        revenue,
        expense,
        profit,
        DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk_asc
    FROM clinic_profit
)
SELECT
    state,
    cid,
    clinic_name,
    revenue,
    expense,
    profit
FROM ranked
WHERE rnk_asc = 2
ORDER BY state;
