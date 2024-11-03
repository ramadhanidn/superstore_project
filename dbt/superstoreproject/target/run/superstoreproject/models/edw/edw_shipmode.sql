-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DEMO_DBT.edw.shipmode as DBT_INTERNAL_DEST
        using DEMO_DBT.edw.shipmode__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.shipid = DBT_INTERNAL_DEST.shipid
            )

    
    when matched then update set
        "SHIPID" = DBT_INTERNAL_SOURCE."SHIPID","SHIPMODE" = DBT_INTERNAL_SOURCE."SHIPMODE","UPDATEDAT" = DBT_INTERNAL_SOURCE."UPDATEDAT","JOBDATE" = DBT_INTERNAL_SOURCE."JOBDATE"
    

    when not matched then insert
        ("SHIPID", "SHIPMODE", "UPDATEDAT", "JOBDATE")
    values
        ("SHIPID", "SHIPMODE", "UPDATEDAT", "JOBDATE")

;
    commit;