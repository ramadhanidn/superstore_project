{{
    config(
        materialized='incremental',
        unique_key = ['rowid', 'orderid']
    )
}}

select
	rowid,
	orderid,
	to_date(orderdate, 'MM/DD/YYYY') as orderdate,
	to_date(shipdate, 'MM/DD/YYYY') as shipdate,
	shipmode,
	customerid,
	customername,
	segment,
	country,
	city,
	state,
	postalcode,
	region,
	productid,
	category,
	subcategory,
	productname,
	sales,
	quantity,
	discount,
	profit,
	created_at,
	updatedat,
	'{{ invocation_id }}' as batchid
from
	raw.sales

{% if is_incremental() %}

where updatedat > (select max(updatedat) from {{ this }})

{% endif %}