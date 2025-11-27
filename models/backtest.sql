{{ config(materialized='table') }}

WITH consensus_aligned AS (

    SELECT
        c.PARAMETERID,
        c.UNIVERSALPARAMETERID,
        c.VACOMPANYID,
        c.PERIOD,
        c.CALENDARPERIOD,
        c.PERIODTYPE,
        c.VALUE,
        c.CURRENT_YEAR,
        c.NEXT_YEAR,
        c.DTYPE
    FROM {{ ref('va_consensus') }} c
),

actuals_aligned AS (

    SELECT
        a.PARAMETERID,
        a.UNIVERSALPARAMETERID,
        a.VACOMPANYID,
        a.PERIOD,
        a.CALENDARPERIOD,
        a.PERIODTYPE,
        a.VALUE,
        a.CURRENT_YEAR,
        a.NEXT_YEAR,
        a.DTYPE
    FROM {{ ref('va_actuals') }} a
)

SELECT * FROM consensus_aligned
UNION ALL
SELECT * FROM actuals_aligned
