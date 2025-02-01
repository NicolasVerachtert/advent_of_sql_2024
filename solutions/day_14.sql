WITH
    unnested AS (
        SELECT
            jsonb_array_elements (cleaning_receipts) AS receipt
        FROM
            santarecords
    )
SELECT
    (receipt - > 'drop_off') AS drop_off,
    (receipt - > 'color') AS color,
    (receipt - > 'garment') AS garment
FROM
    unnested
WHERE
    (receipt - > 'color') = '"green"'
    AND (receipt - > 'garment') = '"suit"'
ORDER BY
    (receipt - > 'drop_off') desc
LIMIT
    1