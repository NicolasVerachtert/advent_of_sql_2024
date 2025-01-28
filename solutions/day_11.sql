WITH
    SeasonOrder AS (
        SELECT
            *,
            CASE
                WHEN season = 'Spring' THEN 1
                WHEN season = 'Summer' THEN 2
                WHEN season = 'Fall' THEN 3
                WHEN season = 'Winter' THEN 4
            END AS season_order
        FROM
            TreeHarvests
    ),
    MovingAverage AS (
        SELECT
            field_name,
            harvest_year,
            season,
            trees_harvested,
            AVG(trees_harvested) OVER (
                PARTITION BY
                    field_name,
                    harvest_year
                ORDER BY
                    season_order ROWS BETWEEN 2 PRECEDING
                    AND CURRENT ROW
            ) AS three_season_moving_avg
        FROM
            SeasonOrder
    )
SELECT
    field_name,
    harvest_year,
    season,
    trees_harvested,
    ROUND(three_season_moving_avg, 2) AS three_season_moving_avg
FROM
    MovingAverage
ORDER BY
    three_season_moving_avg DESC NULLS LAST;