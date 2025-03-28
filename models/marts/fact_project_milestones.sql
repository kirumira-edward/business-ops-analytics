{{
    config(
        materialized='incremental',
        unique_key='MILESTONE_KEY'
    )
}}

with stg_project_milestones as (
    select * from {{ ref('stg_project_milestones') }}
),

stg_projects as (
    select * from {{ ref('stg_projects') }}
),

milestone_metrics as (
    select
        pm.MILESTONE_ID,
        pm.PROJECT_ID,
        p.PROJECT_NAME,
        pm.MILESTONE_NAME,
        pm.PLANNED_DATE,
        pm.ACTUAL_DATE,
        pm.STATUS,
        -- Calculate days variance (negative is early, 0 is on time, positive is late)
        CASE
            WHEN pm.ACTUAL_DATE IS NULL THEN NULL -- Not completed yet
            ELSE DATEDIFF(day, pm.PLANNED_DATE, pm.ACTUAL_DATE)
        END as DAYS_VARIANCE,
        -- Calculate if milestone was on time
        CASE
            WHEN pm.ACTUAL_DATE IS NULL THEN NULL -- Not completed yet
            WHEN pm.ACTUAL_DATE <= pm.PLANNED_DATE THEN TRUE -- On time
            ELSE FALSE -- Late
        END as IS_ON_TIME,
        pm.COMMENTS,
        pm.CREATED_DATE,
        pm.MODIFIED_DATE
    from stg_project_milestones pm
    left join stg_projects p on pm.PROJECT_ID = p.PROJECT_ID
),

final as (
    select
        MILESTONE_ID as MILESTONE_KEY,
        PROJECT_ID,
        PROJECT_NAME,
        MILESTONE_NAME,
        PLANNED_DATE,
        ACTUAL_DATE,
        STATUS,
        DAYS_VARIANCE,
        IS_ON_TIME,
        COMMENTS,
        CREATED_DATE,
        MODIFIED_DATE
    from milestone_metrics
)

select * from final

{% if is_incremental() %}
    where MODIFIED_DATE > (select max(MODIFIED_DATE) from {{ this }})
{% endif %}