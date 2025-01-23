WITH
    avg_per_excercise AS (
        SELECT
            reindeer_id,
            AVG(speed_record) AS avg_speed
        FROM
            training_sessions
        GROUP BY
            reindeer_id,
            exercise_name
    )
SELECT
    r.reindeer_name,
    ROUND(MAX(res.avg_speed), 2) AS highest_average_score
FROM
    avg_per_excercise res
    JOIN reindeers r ON r.reindeer_id = res.reindeer_id
GROUP BY
    r.reindeer_name
ORDER BY
    2 desc
LIMIT
    3