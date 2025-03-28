with source as (
    select * from {{ source('raw', 'RESOURCE_ALLOCATIONS') }}
),

renamed as (
    select
        ALLOCATION_ID,
        PROJECT_ID,
        DEPARTMENT_ID,
        RESOURCE_TYPE,
        ALLOCATION_AMOUNT,
        ALLOCATION_PERCENTAGE,
        START_DATE,
        END_DATE,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed