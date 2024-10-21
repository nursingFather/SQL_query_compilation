WITH comme AS (
    -- Select the top 3 rows from the custinfo table
    SELECT TOP (3) [custID], [name], [amount]
    FROM [ClientWarehouse].[dbo].[custinfo]
)
, comm AS (
    -- Anchor member: start with investor_no = 0 and amount = 0
    SELECT
        0 AS investor_no,
        CAST(0.00 AS FLOAT) AS amount,
        CAST(0.00 AS FLOAT) AS individual_amount

    UNION ALL

    -- Recursive member: increment investor_no, calculate amount and individual_amount
    SELECT  
        investor_no + 1 AS investor_no,
        CAST(c.amount AS FLOAT) AS amount,
        CAST(c.amount / (investor_no + 1) AS FLOAT) AS individual_amount
    FROM comme c
    INNER JOIN comm cc ON 1 = 1
    WHERE investor_no < 3  -- Limit recursion depth to 3 levels
)
SELECT  distinct  investor_no, amount, individual_amount
FROM comm
ORDER BY investor_no, amount;

