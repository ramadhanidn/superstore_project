{{
    config(
        materialized='incremental',
        alias='region',
        unique_key='regionid'
    )
}}

select 
    region, 
    regionid, 
    updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(_airbyte_extracted_at)) AS jobdate
from 
    {{ source('staging', 'region') }}

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}