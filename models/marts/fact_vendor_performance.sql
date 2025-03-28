{{
    config(
        materialized='incremental',
        unique_key='PERFORMANCE_KEY'
    )
}}

with stg_vendor_performance as (
    select * from {{ ref('stg_vendor_performance') }}
),

stg_purchase_orders as (
    select * from {{ ref('stg_purchase_orders') }}
),

performance_metrics as (
    select
        vp.PERFORMANCE_ID,
        vp.VENDOR_ID,
        vp.PO_ID,
        po.PO_DATE,
        po.DELIVERY_DATE as EXPECTED_DELIVERY_DATE,
        vp.DELIVERY_DATE_ACTUAL,
        -- Calculate delivery timeliness (negative is early, 0 is on time, positive is late)
        DATEDIFF(day, po.DELIVERY_DATE, vp.DELIVERY_DATE_ACTUAL) as DELIVERY_DAYS_VARIANCE,
        -- Calculate if delivered on time
        CASE 
            WHEN vp.DELIVERY_DATE_ACTUAL IS NULL THEN NULL -- Not delivered yet
            WHEN vp.DELIVERY_DATE_ACTUAL <= po.DELIVERY_DATE THEN TRUE -- On time
            ELSE FALSE -- Late
        END as IS_ON_TIME,
        vp.QUALITY_RATING,
        vp.PRICE_RATING,
        vp.SERVICE_RATING,
        -- Calculate average rating
        CASE 
            WHEN vp.QUALITY_RATING IS NULL OR vp.PRICE_RATING IS NULL OR vp.SERVICE_RATING IS NULL THEN NULL
            ELSE (vp.QUALITY_RATING + vp.PRICE_RATING + vp.SERVICE_RATING) / 3.0
        END as AVERAGE_RATING,
        vp.COMMENTS,
        vp.CREATED_DATE,
        vp.MODIFIED_DATE
    from stg_vendor_performance vp
    left join stg_purchase_orders po on vp.PO_ID = po.PO_ID
),

final as (
    select
        PERFORMANCE_ID as PERFORMANCE_KEY,
        VENDOR_ID,
        PO_ID,
        PO_DATE,
        EXPECTED_DELIVERY_DATE,
        DELIVERY_DATE_ACTUAL,
        DELIVERY_DAYS_VARIANCE,
        IS_ON_TIME,
        QUALITY_RATING,
        PRICE_RATING,
        SERVICE_RATING,
        AVERAGE_RATING,
        COMMENTS,
        CREATED_DATE,
        MODIFIED_DATE
    from performance_metrics
)

select * from final

{% if is_incremental() %}
    where CREATED_DATE > (select max(CREATED_DATE) from {{ this }})
{% endif %}