WITH RECURSIVE
    rec AS (
        -- SELECT staff_id, staff_name, manager_id, 
        SELECT
            staff_id,
            staff_name,
            manager_id,
            ARRAY[staff_id] as path
        FROM
            staff
        WHERE
            manager_id IS NULL
        UNION ALL
        -- SELECT s.staff_id, s.staff_name, s.manager_id, ARRAY_APPEND(r.path, s.staff_id) as path
        SELECT
            s.staff_id,
            s.staff_name,
            s.manager_id
        FROM
            staff s
            JOIN rec r ON s.manager_id = r.staff_id
    )
SELECT
    staff_id,
    staff_name,
    ARRAY_LENGTH (path, 1) AS level,
    path
FROM
    rec
ORDER BY
    level desc