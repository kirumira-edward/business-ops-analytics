-- Verify that all project budgets are positive
SELECT
    PROJECT_ID,
    PROJECT_NAME,
    BUDGET
FROM {{ ref('dim_projects') }}
WHERE BUDGET <= 0