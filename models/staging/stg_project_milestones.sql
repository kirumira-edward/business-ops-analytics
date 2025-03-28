with source as (
    select * from {{ source('raw', 'PROJECT_MILESTONES') }}
),

renamed as (
    select
        MILESTONE_ID,
        PROJECT_ID,
        MILESTONE_NAME,
        PLANNED_DATE,
        ACTUAL_DATE,
        STATUS,
        COMMENTS,
        CREATED_DATE,
        MODIFIED_DATE
    from source
)

select * from renamed