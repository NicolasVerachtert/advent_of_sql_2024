WITH
    combined_letters AS (
        SELECT
            *
        FROM
            letters_a
        UNION ALL
        SELECT
            *
        FROM
            letters_b
    ),
    filtered_letters AS (
        SELECT
            *
        FROM
            combined_letters
        WHERE
            (VALUE BETWEEN ascii ('a') AND ascii  ('z'))
            OR (VALUE BETWEEN ascii ('A') AND ascii  ('Z'))
            OR VALUE IN (
                ascii (' '),
                ascii ('!'),
                ascii ('"'),
                ascii (''''),
                ascii ('('),
                ascii (')'),
                ascii (','),
                ascii ('-'),
                ascii ('.'),
                ascii (':'),
                ascii (';'),
                ascii ('?')
            )
    )
SELECT
    string_agg (
        chr (VALUE),
        ''
        ORDER BY
            id
    ) AS message
FROM
    filtered_letters fl