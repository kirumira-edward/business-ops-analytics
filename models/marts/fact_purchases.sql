{{
    config(
        materialized='incremental',
        unique_key='PURCHASE_KEY'
    )
}}

with stg_purchase_orders as (
    select * from {{ ref('stg_purchase_orders') }}
),

stg_purchase_order_items as (
    select * from {{ ref('stg_purchase_order_items') }}
),

purchase_items as (
    select
        po.PO_ID,
        po.PO_NUMBER,
        po.VENDOR_ID,
        po.DEPARTMENT_ID,
        po.PROJECT_ID,
        po.LOCATION_ID,
        po.PO_DATE,
        po.DELIVERY_DATE,
        po.STATUS,
        poi.PO_ITEM_ID,
        poi.MATERIAL_ID,
        poi.QUANTITY,
        poi.UNIT_PRICE,
        poi.TOTAL_PRICE
    from stg_purchase_orders po
    inner join stg_purchase_order_items poi on po.PO_ID = poi.PO_ID
),

final as (
    select
        pi.PO_ITEM_ID as PURCHASE_KEY,
        pi.PO_ID,
        pi.PO_NUMBER,
        pi.VENDOR_ID,
        pi.DEPARTMENT_ID,
        pi.PROJECT_ID,
        pi.LOCATION_ID,
        pi.MATERIAL_ID,
        pi.PO_DATE,
        pi.DELIVERY_DATE,
        pi.STATUS,
        pi.QUANTITY,
        pi.UNIT_PRICE,
        pi.TOTAL_PRICE
    from purchase_items pi
)

select * from final

{% if is_incremental() %}
    where PO_DATE > (select max(PO_DATE) from {{ this }})
{% endif %}