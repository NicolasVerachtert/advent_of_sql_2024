WITH
    experience_info AS (
        SELECT
            primary_skill,
            COUNT(*) / 2 AS cnt_limit
        FROM
            workshop_elves
        GROUP BY
            primary_skill
    ),
    ranked_elves AS (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY
                    primary_skill
                ORDER BY
                    years_experience DESC,
                    elf_id ASC
            ) AS rank_desc,
            ROW_NUMBER() OVER (
                PARTITION BY
                    primary_skill
                ORDER BY
                    years_experience ASC,
                    elf_id ASC
            ) AS rank_asc
        FROM
            workshop_elves
    )
SELECT
    e1.elf_id AS elf_1_id,
    e2.elf_id AS elf_2_id,
    e1.primary_skill AS shared_skill,
    ROW_NUMBER() OVER(PARTITION BY e1.primary_skill ORDER BY e1.rank_desc) as rn
FROM
    ranked_elves e1
    JOIN ranked_elves e2 ON e1.primary_skill = e2.primary_skill
    AND e1.rank_desc = e2.rank_asc
    AND e1.elf_id != e2.elf_id
    JOIN experience_info ei ON e1.primary_skill = ei.primary_skill
    AND e1.rank_desc <= ei.cnt_limit
ORDER BY
    shared_skill