

select
	rowid,
	orderid,
	to_date(orderdate, 'MM/DD/YYYY') as orderdate,
	to_date(shipdate, 'MM/DD/YYYY') as shipdate,
    sm.shipid,
	customerid,
	productid,
	sales,
	quantity,
	discount,
	profit,
	s.updatedat,
    CONVERT_TIMEZONE('UTC', 'Asia/Jakarta', TO_TIMESTAMP_NTZ(s._airbyte_extracted_at)) AS jobdate
from
    demo_dbt.staging.sales s
left join
    demo_dbt.staging.shipmode sm
on
    s.shipmode = sm.shipmode



    where s.updatedat > (select max(updatedat) from DEMO_DBT.edw.sales)

