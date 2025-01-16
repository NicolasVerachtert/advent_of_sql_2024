WITH
    skips AS (
        SELECT
            up.song_id,
            COUNT(*) AS total_skips
        FROM
            user_plays up
            JOIN songs s ON s.song_id = up.song_id
        WHERE
            up.duration < s.song_duration
            OR up.duration IS NULL
        GROUP BY
            up.song_id
    ),
    plays AS (
        SELECT
            up.song_id,
            COUNT(*) AS total_plays
        FROM
            user_plays up
        GROUP BY
            up.song_id
    )
SELECT
    s.song_title,
    p.total_plays,
    sk.total_skips
FROM
    songs s
    LEFT JOIN skips sk ON s.song_id = sk.song_id
    LEFT JOIN plays p ON s.song_id = p.song_id
ORDER BY
    p.total_plays DESC,
    sk.total_skips ASC
LIMIT
    1;