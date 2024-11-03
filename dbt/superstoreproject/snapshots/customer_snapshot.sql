{% snapshot customer_snapshot %}

{{
    config(
        target_schema = 'snapshots',
        unique_key = 'customerid',
        strategy = 'timestamp',
        updated_at = 'updatedat'
    )
}}


select * from {{ source('staging','customer') }}

{% endsnapshot %}