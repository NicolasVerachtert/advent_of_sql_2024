SELECT
    c.name AS name,
    LOWER(wl.wishes - > > 'first_choice') AS primary_wish,
    LOWER(wl.wishes - > > 'second_choice') AS backup_wish,
    LOWER(wl.wishes - > 'colors' - > > 0) AS favorite_color,
    json_array_length (wl.wishes - > 'colors') AS color_count,
    CASE tc.difficulty_to_make
        WHEN 1 THEN 'Simple Gift'
        WHEN 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END AS gift_complexity,
    CASE tc.category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM
    wish_lists wl
    JOIN children c ON wl.child_id = c.child_id
    JOIN toy_catalogue tc ON wl.wishes - > > 'first_choice' = tc.toy_name
ORDER BY
    c.name ASC
LIMIT
    5