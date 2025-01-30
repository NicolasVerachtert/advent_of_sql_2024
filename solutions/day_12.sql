WITH
    dt AS (
        SELECT
            g.gift_name,
            COUNT(*) AS requested
        FROM
            gift_requests req
            JOIN gifts g ON req.gift_id = g.gift_id
        GROUP BY
            g.gift_name
        ORDER BY
            2 desc
    )
SELECT
    dt.gift_name,
    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY
                requested
        )::numeric,
        2
    ) AS overall_rank
FROM
    dt
ORDER BY
    overall_rank desc,
    gift_name asc