SELECT
    c.name AS child_name,
    g.name AS gift_name,
    g.price AS gift_price
FROM
    children c
    RIGHT JOIN gifts g ON g.child_id = c.child_id
WHERE
    g.price > (
        SELECT
            AVG(price)
        FROM
            gifts
    )
ORDER BY
    g.price asc
LIMIT
    1