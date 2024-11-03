{{
    config(
        materialized='incremental',
        unique_key='productid'
    )
}}

select
	productid,
	productname,
	category,
	subcategory,
	updatedat,
	'{{ invocation_id }}' as batchid
from
	raw.product

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}