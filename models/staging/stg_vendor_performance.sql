with source as (
    select * from {{ source('raw', 'VENDOR_PERFORMANCE') }}
),

renamed as (
    select
        PERFORMANCE_ID,
        VENDOR_ID,
        PO_ID,
        DELIVERY_DATE_ACTUAL,
        QUALITY_RATING,
        PRICE_RATING,
        SERVICE_RATING,
        COMMENTS,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed