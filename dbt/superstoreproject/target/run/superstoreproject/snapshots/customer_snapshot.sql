
      begin;
    merge into "DEMO_DBT"."SNAPSHOTS"."CUSTOMER_SNAPSHOT" as DBT_INTERNAL_DEST
    using "DEMO_DBT"."SNAPSHOTS"."CUSTOMER_SNAPSHOT__dbt_tmp" as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     and DBT_INTERNAL_DEST.dbt_valid_to is null
     and DBT_INTERNAL_SOURCE.dbt_change_type in ('update', 'delete')
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert ("_AIRBYTE_RAW_ID", "_AIRBYTE_EXTRACTED_AT", "_AIRBYTE_META", "_AIRBYTE_GENERATION_ID", "CITY", "STATE", "COUNTRY", "SEGMENT", "UPDATEDAT", "CUSTOMERID", "POSTALCODE", "CUSTOMERNAME", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")
        values ("_AIRBYTE_RAW_ID", "_AIRBYTE_EXTRACTED_AT", "_AIRBYTE_META", "_AIRBYTE_GENERATION_ID", "CITY", "STATE", "COUNTRY", "SEGMENT", "UPDATEDAT", "CUSTOMERID", "POSTALCODE", "CUSTOMERNAME", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")

;
    commit;
  