{{
    config(
        materialized='incremental',
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
	'{{ invocation_id }}' as batchid
from
	raw.customer

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}