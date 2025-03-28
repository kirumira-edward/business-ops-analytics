with source as (
    select * from {{ source('raw', 'PROJECTS') }}
),

renamed as (
    select
        PROJECT_ID,
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
    from source
)

select * from renamed