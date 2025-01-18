WITH combined_data AS (
    SELECT
        id,
        CASE (xpath('/*/@version', menu_data)::TEXT[])[1]
            WHEN '1.0' THEN CAST((xpath('//total_count/text()', menu_data)::TEXT[])[1] AS INT)
            WHEN '2.0' THEN CAST((xpath('//total_guests/text()', menu_data)::TEXT[])[1] AS INT)
            WHEN '3.0' THEN CAST((xpath('//total_present/text()', menu_data)::TEXT[])[1] AS INT) 
            END AS headcount,
        xpath('//food_item_id/text()', menu_data)::TEXT[] AS food_items
    FROM 
        christmas_menus
),
unnested_data AS (
    SELECT
        UNNEST (food_items) AS food_item
    FROM
        combined_data
    WHERE
        headcount > 78
)
SELECT
    food_item,
    COUNT(food_item)
FROM
    unnested_data
GROUP BY
    food_item
ORDER BY
    2 desc


