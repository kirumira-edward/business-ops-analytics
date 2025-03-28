with source as (
    select * from {{ source('raw', 'PURCHASE_ORDER_ITEMS') }}
),

renamed as (
    select
        PO_ITEM_ID,
        PO_ID,
        MATERIAL_ID,
        QUANTITY,
        UNIT_PRICE,
        TOTAL_PRICE,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed