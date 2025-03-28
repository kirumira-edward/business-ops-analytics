{{
    config(
        materialized='table',
        unique_key='VENDOR_KEY'
    )
}}

with stg_vendors as (
    select * from {{ ref('stg_vendors') }}
),

final as (
    select
        VENDOR_ID as VENDOR_KEY,
        VENDOR_NAME,
        VENDOR_CATEGORY,
        CONTACT_NAME,
        CONTACT_EMAIL,
        ACTIVE_FLAG,
        CREATED_DATE,
        MODIFIED_DATE
    from stg_vendors
)

select * from final