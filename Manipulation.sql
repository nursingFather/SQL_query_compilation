use trial;

-- Create a temporary table to generate the week data
CREATE TEMPORARY TABLE IF NOT EXISTS TempWeeks AS (
    SELECT 
        DATE_ADD('2023-04-03', INTERVAL (seq - 1) * 7 DAY) AS week_start
    FROM (
        SELECT 
            ROW_NUMBER() OVER () AS seq
        FROM debits -- You can use any table with enough rows here
        LIMIT 1000 -- Adjust this limit to generate enough weeks
    ) AS seq_nums
    WHERE DATE_ADD('2023-04-03', INTERVAL (seq - 1) * 7 DAY) <= CURRENT_DATE
);

-- Now, you can use the temporary table in your query
SELECT
    u.source,
    w.week_start AS "Week Joined",
    COALESCE(avg_d1.amount, 0) AS "D1",
    COALESCE(avg_d7.amount, 0) AS "D7",
    COALESCE(avg_d30.amount, 0) AS "D30",
    COALESCE(ltv.ltv_amount, 0) AS "LTV",
    COALESCE(median.median_amount, 0) AS "Median",
    COALESCE(debits_ltv.ltv_amount - credits_ltv.ltv_amount, 0) AS "LTV Balance"
FROM
    (SELECT DISTINCT source FROM users) u
CROSS JOIN
    TempWeeks w
LEFT JOIN (
    SELECT
        d.user_id,
        AVG(d.amount) AS amount,
        u.source
    FROM
        debits d
    JOIN
        users u ON d.user_id = u.id
    WHERE
        d.date BETWEEN u.date_joined AND DATE_ADD(u.date_joined, INTERVAL 1 DAY)
    GROUP BY
        d.user_id, u.source
) AS avg_d1 ON u.source = avg_d1.source AND u.id = avg_d1.user_id
LEFT JOIN (
    SELECT
        d.user_id,
        AVG(d.amount) AS amount,
        u.source
    FROM
        debits d
    JOIN
        users u ON d.user_id = u.id
    WHERE
        d.date BETWEEN u.date_joined AND DATE_ADD(u.date_joined, INTERVAL 7 DAY)
    GROUP BY
        d.user_id, u.source
) AS avg_d7 ON u.source = avg_d7.source AND u.id = avg_d7.user_id
LEFT JOIN (
    SELECT
        d.user_id,
        AVG(d.amount) AS amount,
        u.source
    FROM
        debits d
    JOIN
        users u ON d.user_id = u.id
    WHERE
        d.date BETWEEN u.date_joined AND DATE_ADD(u.date_joined, INTERVAL 30 DAY)
    GROUP BY
        d.user_id, u.source
) AS avg_d30 ON u.source = avg_d30.source AND u.id = avg_d30.user_id
LEFT JOIN (
    SELECT
        user_id,
        AVG(amount) AS ltv_amount,
        source
    FROM
        (
            SELECT user_id, date, amount, source FROM debits
            UNION ALL
            SELECT user_id, date, amount, source FROM credits
        ) combined
    GROUP BY
        user_id, source
) AS ltv ON u.source = ltv.source AND u.id = ltv.user_id
LEFT JOIN (
    SELECT
        user_id,
        (
            SELECT
                amount
            FROM
                (
                    SELECT
                        d2.amount,
                        ROW_NUMBER() OVER (ORDER BY d2.amount) AS rn,
                        COUNT(*) OVER () AS cnt
                    FROM
                        (
                            SELECT user_id, date, amount FROM debits
                            UNION ALL
                            SELECT user_id, date, amount FROM credits
                        ) d2
                    WHERE
                        d2.user_id = d1.user_id
                ) AS sub
            WHERE
                rn = (cnt + 1) / 2
        ) AS median_amount,
        source
    FROM
        (
            SELECT user_id, date, amount, source FROM debits
            UNION ALL
            SELECT user_id, date, amount, source FROM credits
        ) d1
    GROUP BY
        user_id, source
) AS median ON u.source = median.source AND u.id = median.user_id
LEFT JOIN (
    SELECT
        user_id,
        SUM(amount) AS ltv_amount,
        source
    FROM
        (
            SELECT user_id, date, amount, source FROM debits
            UNION ALL
            SELECT user_id, date, amount, source FROM credits
        ) combined
    GROUP BY
        user_id, source
) AS debits_ltv ON u.source = debits_ltv.source AND u.id = debits_ltv.user_id
LEFT JOIN (
    SELECT
        user_id,
        SUM(amount) AS ltv_amount,
        source
    FROM
        credits
    GROUP BY
        user_id, source
) AS credits_ltv ON u.source = credits_ltv.source AND u.id = credits_ltv.user_id
ORDER BY
    u.source,
    w.week_start;

-- Drop the temporary table when done
DROP TEMPORARY TABLE IF EXISTS TempWeeks;




