

select 
    region, 
    regionid, 
    updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(_airbyte_extracted_at)) AS jobdate
from 
    demo_dbt.staging.region



where updatedat > (select max(updatedat) from DEMO_DBT.edw.region)

