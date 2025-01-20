SELECT
    current_day.production_date AS production_date,
    current_day.toys_produced AS toys_produced,
    previous_day.toys_produced AS previous_day_production,
    (
        current_day.toys_produced - previous_day.toys_produced
    ) AS production_change,
    ROUND(
        (
            (
                current_day.toys_produced - previous_day.toys_produced
            ) * 100.0 / previous_day.toys_produced
        ),
        2
    ) AS production_change_percentage
FROM
    toy_production current_day
    JOIN toy_production previous_day ON current_day.production_date = previous_day.production_date + INTERVAL '1 day'
ORDER BY
    5 desc