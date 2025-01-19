with tag_analysis AS (
    SELECT
        toy_id,
        toy_name,
        ARRAY(SELECT unnest(new_tags) EXCEPT SELECT unnest(previous_tags)) AS added_tags,
        ARRAY(SELECT unnest(previous_tags) INTERSECT SELECT unnest(new_tags)) AS unchanged_tags,
        ARRAY(SELECT unnest(previous_tags) EXCEPT SELECT unnest(new_tags)) AS removed_tags
    FROM toy_production
)

SELECT
    toy_id,
    array_length(added_tags, 1) AS added_count,
    array_length(unchanged_tags, 1) AS unchanged_count,
    array_length(removed_tags, 1) AS removed_count
FROM tag_analysis
ORDER BY added_count DESC NULLS LAST
LIMIT 1;