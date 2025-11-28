{{ config(
    materialized = 'table',
    database = 'CE_AUTOMATION',
    schema   = 'PUBLIC',
    alias    = 'CE_1_HISTORICAL'
) }}

WITH base AS (
    SELECT
        SYMBOL,
        SEGMENT_NAME,
        PARTIAL_PERIOD_FLAG,
        PERIOD_TYPE,
        PERIOD,
        PERIOD_START_DT::DATE AS PERIOD_START_DT,
        PTD_END_DT::DATE      AS PTD_END_DT,
        YA_PERIOD,
        PTD_SPEND_USD_YOY,
        PTD_TRANS_YOY,
        VERSION,
        TRANS_COUNT,
        SPEND_AMOUNT_USD
    FROM {{ source('ce_usa1', 'PERIOD_SYM_SEG_EMAX') }}
    WHERE SYMBOL IS NOT NULL
      AND PERIOD_TYPE NOT IN ('HALF', 'WEEK', 'MONTH')
)

SELECT *
FROM base
ORDER BY SYMBOL, SEGMENT_NAME, PERIOD_START_DT