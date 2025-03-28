with source as (
    select * from {{ source('raw', 'VENDORS') }}
),

renamed as (
    select
        VENDOR_ID,
        VENDOR_NAME,
        VENDOR_CATEGORY,
        CONTACT_NAME,
        CONTACT_EMAIL,
        ACTIVE_FLAG,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed