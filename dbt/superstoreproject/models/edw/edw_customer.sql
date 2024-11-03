{{
    config(
        materialized='incremental',
        alias='customer',
        unique_key='customerid'
    )
}}

select
	customerid,
	customername,
	segment,
	country,
	city,
	state,
	postalcode,
	updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(_airbyte_extracted_at)) AS jobdate
from
	{{ source('staging', 'customer') }}

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}