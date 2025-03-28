{{
    config(
        materialized='table'
    )
}}

WITH date_spine AS (
    SELECT DATEADD(DAY, SEQ4(), TO_DATE('2023-01-01')) AS DATE_DAY
    FROM TABLE(GENERATOR(ROWCOUNT => 731)) -- 2 years of dates
    WHERE DATE_DAY <= TO_DATE('2024-12-31')
),

date_dimension AS (
    SELECT
        DATE_DAY,
        YEAR(DATE_DAY) AS YEAR,
        MONTH(DATE_DAY) AS MONTH,
        MONTHNAME(DATE_DAY) AS MONTH_NAME,
        DAY(DATE_DAY) AS DAY_OF_MONTH,
        DAYOFWEEK(DATE_DAY) AS DAY_OF_WEEK_NUM,
        DAYNAME(DATE_DAY) AS DAY_OF_WEEK,
        CASE 
            WHEN DAYOFWEEK(DATE_DAY) IN (0, 6) THEN TRUE 
            ELSE FALSE 
        END AS IS_WEEKEND,
        CASE
            WHEN DATE_DAY = LAST_DAY(DATE_DAY) THEN TRUE
            ELSE FALSE
        END AS IS_LAST_DAY_OF_MONTH,
        
        -- Fiscal year (assuming fiscal year starts July 1)
        CASE 
            WHEN MONTH(DATE_DAY) >= 7 THEN YEAR(DATE_DAY) + 1
            ELSE YEAR(DATE_DAY)
        END AS FISCAL_YEAR,
        
        -- Quarter calculations
        QUARTER(DATE_DAY) AS QUARTER,
        'Q' || QUARTER(DATE_DAY) || '-' || YEAR(DATE_DAY) AS QUARTER_NAME,
        
        -- Case for identifying holidays (simplified example)
        CASE 
            WHEN MONTH(DATE_DAY) = 1 AND DAY(DATE_DAY) = 1 THEN 'New Year''s Day'
            WHEN MONTH(DATE_DAY) = 12 AND DAY(DATE_DAY) = 25 THEN 'Christmas Day'
            ELSE NULL
        END AS HOLIDAY_NAME
    FROM date_spine
)

SELECT * FROM date_dimension