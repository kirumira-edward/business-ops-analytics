{% snapshot vendors_snapshot %}

{{
    config(
      target_schema='ANALYTICS',
      unique_key='VENDOR_ID',
      strategy='timestamp',
      updated_at='MODIFIED_DATE',
    )
}}

select * from {{ source('raw', 'VENDORS') }}

{% endsnapshot %}