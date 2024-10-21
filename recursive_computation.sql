WITH recur AS (
    -- Select the root employees (those without a boss)
    SELECT 
        id, 
        first_name, 
        boss_id,
        0 AS hierarchy_level
    FROM [dbo].[employees]
    WHERE boss_id IS NULL

    UNION ALL

    -- Recursively find all employees who report to the previous level
    SELECT 
        e.id, 
        e.first_name, 
        e.boss_id,
        r.hierarchy_level + 1 AS hierarchy_level
    FROM [dbo].[employees] e
    INNER JOIN recur r ON e.boss_id = r.id
)
SELECT 
    r.first_name AS employee_first_name,
    e.first_name AS boss_first_name,

    r.hierarchy_level
FROM recur r
LEFT JOIN [dbo].[employees] e ON r.boss_id = e.id
ORDER BY r.hierarchy_level, r.boss_id;
