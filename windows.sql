WITH highest AS (
  SELECT
    branch,
    date,
    MAX(unit_price) AS Highest_Amount
  FROM sales
  GROUP BY branch, date
)
SELECT
  sales.*,
  h.highest_price
FROM sales
JOIN highest h
  ON sales.branch = h.branch
    AND sales.date = h.date