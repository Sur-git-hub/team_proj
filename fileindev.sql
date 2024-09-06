WITH sales_per_ bike AS (
    SELECT c.id,
         c.car_make,
         c.model,
           c.motor_type,
           c.year_of_production,
           AVG(cs.sales)::INT AS a
    FROM cars c JOIN car_sales cs ON c.id = cs.cars_id
    WHERE c.year_of_production > 2024
    GROUP BY c.id, c.car_make, c.model, c.motor_type, c.year_of_production
),
-----add yearly sale 2020
budget_per_annually AS (
    SELECT *,
         average_sales_2024 * 12 AS annual_planned_sales_2020
    FROM sales_per_car
)
-- by jai
SELECT 
     b.version --version added
     b.car_make,
     b.model,
     b.motor_type,
     b.year_of_production,
     SUM(cs.sales) AS actual_ytd_sales_2022,
     b.annual_planned_sales_2020,
     b.annual_planned_sales_2020 - SUM(cs.sales) AS remaining_annual_sales_2022
FROM budget_per_annually b
JOIN car_sales cs
ON b.id = cs.cars_id
GROUP BY b.car_make, b.model, b.motor_type, b.year_of_production, b.annual_planned_sales_2020;


