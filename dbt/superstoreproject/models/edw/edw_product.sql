{{
    config(
        materialized='incremental',
        alias='product',
        unique_key='productid'
    )
}}

select
	productid,
	productname,
	category,
	subcategory,
	updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(_airbyte_extracted_at)) AS jobdate
from
	{{ source('staging', 'product') }}

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}