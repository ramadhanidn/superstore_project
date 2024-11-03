-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
        
    

    

    merge into DEMO_DBT.edw.sales as DBT_INTERNAL_DEST
        using DEMO_DBT.edw.sales__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.rowid = DBT_INTERNAL_DEST.rowid
                ) and (
                    DBT_INTERNAL_SOURCE.orderid = DBT_INTERNAL_DEST.orderid
                )

    
    when matched then update set
        "ROWID" = DBT_INTERNAL_SOURCE."ROWID","ORDERID" = DBT_INTERNAL_SOURCE."ORDERID","ORDERDATE" = DBT_INTERNAL_SOURCE."ORDERDATE","SHIPDATE" = DBT_INTERNAL_SOURCE."SHIPDATE","SHIPID" = DBT_INTERNAL_SOURCE."SHIPID","CUSTOMERID" = DBT_INTERNAL_SOURCE."CUSTOMERID","PRODUCTID" = DBT_INTERNAL_SOURCE."PRODUCTID","SALES" = DBT_INTERNAL_SOURCE."SALES","QUANTITY" = DBT_INTERNAL_SOURCE."QUANTITY","DISCOUNT" = DBT_INTERNAL_SOURCE."DISCOUNT","PROFIT" = DBT_INTERNAL_SOURCE."PROFIT","UPDATEDAT" = DBT_INTERNAL_SOURCE."UPDATEDAT","JOBDATE" = DBT_INTERNAL_SOURCE."JOBDATE"
    

    when not matched then insert
        ("ROWID", "ORDERID", "ORDERDATE", "SHIPDATE", "SHIPID", "CUSTOMERID", "PRODUCTID", "SALES", "QUANTITY", "DISCOUNT", "PROFIT", "UPDATEDAT", "JOBDATE")
    values
        ("ROWID", "ORDERID", "ORDERDATE", "SHIPDATE", "SHIPID", "CUSTOMERID", "PRODUCTID", "SALES", "QUANTITY", "DISCOUNT", "PROFIT", "UPDATEDAT", "JOBDATE")

;
    commit;