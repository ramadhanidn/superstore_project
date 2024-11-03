{{
    config(
        materialized='incremental',
        unique_key='regionid'
    )
}}

select region, 
       regionid::int as regionid, 
       updatedat::timestamp as updatedat,
	   '{{ invocation_id }}' as batchid
from raw.region

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}