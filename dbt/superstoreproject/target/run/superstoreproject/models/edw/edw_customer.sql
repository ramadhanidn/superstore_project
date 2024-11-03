-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DEMO_DBT.edw.customer as DBT_INTERNAL_DEST
        using DEMO_DBT.edw.customer__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.customerid = DBT_INTERNAL_DEST.customerid
            )

    
    when matched then update set
        "CUSTOMERID" = DBT_INTERNAL_SOURCE."CUSTOMERID","CUSTOMERNAME" = DBT_INTERNAL_SOURCE."CUSTOMERNAME","SEGMENT" = DBT_INTERNAL_SOURCE."SEGMENT","COUNTRY" = DBT_INTERNAL_SOURCE."COUNTRY","CITY" = DBT_INTERNAL_SOURCE."CITY","STATE" = DBT_INTERNAL_SOURCE."STATE","POSTALCODE" = DBT_INTERNAL_SOURCE."POSTALCODE","UPDATEDAT" = DBT_INTERNAL_SOURCE."UPDATEDAT","JOBDATE" = DBT_INTERNAL_SOURCE."JOBDATE"
    

    when not matched then insert
        ("CUSTOMERID", "CUSTOMERNAME", "SEGMENT", "COUNTRY", "CITY", "STATE", "POSTALCODE", "UPDATEDAT", "JOBDATE")
    values
        ("CUSTOMERID", "CUSTOMERNAME", "SEGMENT", "COUNTRY", "CITY", "STATE", "POSTALCODE", "UPDATEDAT", "JOBDATE")

;
    commit;