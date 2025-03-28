{% snapshot projects_snapshot %}

{{
    config(
      target_schema='ANALYTICS',
      unique_key='PROJECT_ID',
      strategy='timestamp',
      updated_at='MODIFIED_DATE',
    )
}}

select * from {{ source('raw', 'PROJECTS') }}

{% endsnapshot %}