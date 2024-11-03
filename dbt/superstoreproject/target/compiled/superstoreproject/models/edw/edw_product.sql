

select
	productid,
	productname,
	category,
	subcategory,
	updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(_airbyte_extracted_at)) AS jobdate
from
	demo_dbt.staging.product



where updatedat > (select max(updatedat) from DEMO_DBT.edw.product)

