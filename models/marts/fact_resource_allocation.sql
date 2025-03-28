{{
    config(
        materialized='incremental',
        unique_key='ALLOCATION_KEY'
    )
}}

with stg_resource_allocations as (
    select * from {{ ref('stg_resource_allocations') }}
),

final as (
    select
        ALLOCATION_ID as ALLOCATION_KEY,
        PROJECT_ID,
        DEPARTMENT_ID,
        RESOURCE_TYPE,
        ALLOCATION_AMOUNT,
        ALLOCATION_PERCENTAGE,
        START_DATE,
        END_DATE,
        DATEDIFF(day, START_DATE, END_DATE) as ALLOCATION_DURATION_DAYS,
        CREATED_DATE,
        MODIFIED_DATE
    from stg_resource_allocations
)

select * from final

{% if is_incremental() %}
    where MODIFIED_DATE > (select max(MODIFIED_DATE) from {{ this }})
{% endif %}

