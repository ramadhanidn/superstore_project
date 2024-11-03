{{
    config(
        materialized='incremental',
        alias='shipmode',
        unique_key='shipid'
    )
}}

select
	shipid,
	shipmode,
	updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(_airbyte_extracted_at)) AS jobdate
from
	{{ source('staging', 'shipmode') }}

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}