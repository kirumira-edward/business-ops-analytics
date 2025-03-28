{{
    config(
        materialized='table',
        unique_key='MATERIAL_KEY'
    )
}}

with stg_materials as (
    select * from {{ ref('stg_materials') }}
),

final as (
    select
        MATERIAL_ID as MATERIAL_KEY,
        MATERIAL_NAME,
        MATERIAL_DESCRIPTION,
        CATEGORY,
        SUBCATEGORY,
        UNIT_OF_MEASURE,
        UNIT_COST,
        CREATED_DATE,
        MODIFIED_DATE
    from stg_materials
)

select * from final