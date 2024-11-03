{{
    config(
        materialized='incremental',
        unique_key='shipid'
    )
}}

select
	shipid,
	shipmode,
	updatedat,
	'{{ invocation_id }}' as batchid
from
	raw.shipmode

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}