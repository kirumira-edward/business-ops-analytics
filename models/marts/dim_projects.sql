{{
    config(
        materialized='table',
        unique_key='PROJECT_KEY'
    )
}}

with stg_projects as (
    select * from {{ ref('stg_projects') }}
),

final as (
    select
        PROJECT_ID as PROJECT_KEY,
        PROJECT_NAME,
        PROJECT_DESCRIPTION,
        DEPARTMENT_ID,
        PROJECT_MANAGER_ID,
        START_DATE,
        TARGET_END_DATE,
        ACTUAL_END_DATE,
        STATUS,
        BUDGET,
        CREATED_DATE,
        MODIFIED_DATE
    from stg_projects
)

select * from final