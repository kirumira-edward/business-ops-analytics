{{
    config(
        materialized='table',
        unique_key='LOCATION_KEY'
    )
}}

with stg_locations as (
    select * from {{ ref('stg_locations') }}
),

final as (
    select
        LOCATION_ID as LOCATION_KEY,
        LOCATION_NAME,
        ADDRESS,
        CITY,
        COUNTRY,
        REGION,
        IS_ACTIVE,
        CREATED_DATE,
        MODIFIED_DATE
    from stg_locations
)

select * from final