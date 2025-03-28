with source as (
    select * from {{ source('raw', 'MATERIALS') }}
),

renamed as (
    select
        MATERIAL_ID,
        MATERIAL_NAME,
        MATERIAL_DESCRIPTION,
        CATEGORY,
        SUBCATEGORY,
        UNIT_OF_MEASURE,
        UNIT_COST,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed