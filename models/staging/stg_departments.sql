with source as (
    select * from {{ source('raw', 'DEPARTMENTS') }}
),

renamed as (
    select
        DEPARTMENT_ID,
        DEPARTMENT_NAME,
        PARENT_DEPARTMENT_ID,
        MANAGER_ID,
        COST_CENTER,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed