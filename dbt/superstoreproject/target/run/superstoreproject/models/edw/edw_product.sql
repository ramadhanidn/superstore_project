-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into DEMO_DBT.edw.product as DBT_INTERNAL_DEST
        using DEMO_DBT.edw.product__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.productid = DBT_INTERNAL_DEST.productid
            )

    
    when matched then update set
        "PRODUCTID" = DBT_INTERNAL_SOURCE."PRODUCTID","PRODUCTNAME" = DBT_INTERNAL_SOURCE."PRODUCTNAME","CATEGORY" = DBT_INTERNAL_SOURCE."CATEGORY","SUBCATEGORY" = DBT_INTERNAL_SOURCE."SUBCATEGORY","UPDATEDAT" = DBT_INTERNAL_SOURCE."UPDATEDAT","JOBDATE" = DBT_INTERNAL_SOURCE."JOBDATE"
    

    when not matched then insert
        ("PRODUCTID", "PRODUCTNAME", "CATEGORY", "SUBCATEGORY", "UPDATEDAT", "JOBDATE")
    values
        ("PRODUCTID", "PRODUCTNAME", "CATEGORY", "SUBCATEGORY", "UPDATEDAT", "JOBDATE")

;
    commit;