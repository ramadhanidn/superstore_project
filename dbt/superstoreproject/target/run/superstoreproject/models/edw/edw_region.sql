-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DEMO_DBT.edw.region as DBT_INTERNAL_DEST
        using DEMO_DBT.edw.region__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.regionid = DBT_INTERNAL_DEST.regionid
            )

    
    when matched then update set
        "REGION" = DBT_INTERNAL_SOURCE."REGION","REGIONID" = DBT_INTERNAL_SOURCE."REGIONID","UPDATEDAT" = DBT_INTERNAL_SOURCE."UPDATEDAT","JOBDATE" = DBT_INTERNAL_SOURCE."JOBDATE"
    

    when not matched then insert
        ("REGION", "REGIONID", "UPDATEDAT", "JOBDATE")
    values
        ("REGION", "REGIONID", "UPDATEDAT", "JOBDATE")

;
    commit;