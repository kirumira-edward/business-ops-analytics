with source as (
    select * from {{ source('raw', 'LOCATIONS') }}
),

renamed as (
    select
        LOCATION_ID,
        LOCATION_NAME,
        ADDRESS,
        CITY,
        COUNTRY,
        REGION,
        IS_ACTIVE,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed