{{
    config(
        materialized='table',
        unique_key='DEPARTMENT_KEY'
    )
}}

with stg_departments as (
    select * from {{ ref('stg_departments') }}
),

final as (
    select
        DEPARTMENT_ID as DEPARTMENT_KEY,
        DEPARTMENT_NAME,
        PARENT_DEPARTMENT_ID,
        MANAGER_ID,
        COST_CENTER,
        CREATED_DATE,
        MODIFIED_DATE
    from stg_departments
)

select * from final