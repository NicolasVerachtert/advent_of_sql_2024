-- CASE Solution
WITH
    data AS (
        SELECT
            DATE,
            SUM( CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END ) AS eggnog,
            SUM( CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END ) AS schnapps,
            SUM( CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END ) AS cocoa
        FROM
            drinks
        GROUP BY
            DATE
    )
SELECT
    *
FROM
    data
WHERE
    cocoa = 38
    AND schnapps = 298
    AND eggnog = 198;