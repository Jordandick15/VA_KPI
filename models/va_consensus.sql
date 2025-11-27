{{ config(materialized='table') }}

WITH years AS (
    SELECT
        EXTRACT(YEAR FROM CURRENT_DATE())        AS current_year,
        EXTRACT(YEAR FROM CURRENT_DATE()) + 1    AS next_year
)

SELECT
    c.PARAMETERID,
    c.UNIVERSALPARAMETERID,
    c.VACOMPANYID,
    c.PERIOD,
    c.CALENDARPERIOD,
    c.PERIODTYPE,
    c.VALUE,
    EXTRACT(YEAR FROM CURRENT_DATE()) AS CURRENT_YEAR,
    EXTRACT(YEAR FROM CURRENT_DATE()) + 1 AS NEXT_YEAR,
    'CONSENSUS' AS DTYPE
FROM {{ source('va', 'consensus_v2_latest') }} c
JOIN years y
    ON (
        c.PERIOD LIKE '%' || y.current_year || '%'
        OR
        c.PERIOD LIKE '%' || y.next_year || '%'
    )
WHERE c.UNIVERSALPARAMETERID = '4435'