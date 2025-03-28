with source as (
    select * from {{ source('raw', 'PURCHASE_ORDERS') }}
),

renamed as (
    select
        PO_ID,
        PO_NUMBER,
        VENDOR_ID,
        DEPARTMENT_ID,
        PROJECT_ID,
        LOCATION_ID,
        PO_DATE,
        DELIVERY_DATE,
        STATUS,
        TOTAL_AMOUNT,
        CREATED_BY,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed