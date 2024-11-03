

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
	demo_dbt.staging.customer



where updatedat > (select max(updatedat) from DEMO_DBT.edw.customer)

