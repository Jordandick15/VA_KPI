{{ config(materialized='table') }}

SELECT *
FROM {{ source('va', 'global_meta') }}
WHERE SDPARAMETERID = '4435'
