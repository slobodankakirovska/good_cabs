use trips_db;

SELECT 
    city_name,
    month_name AS highest_revenue_month,
    max_revenue AS revenue,
    (max_revenue / total_city_revenue) * 100 AS percentage_contribution
FROM 
    (
        SELECT 
            dc.city_name,
            dd.month_name,
            SUM(ft.fare_amount) AS total_monthly_revenue,
            MAX(SUM(ft.fare_amount)) OVER (PARTITION BY dc.city_name) AS max_revenue,
            SUM(SUM(ft.fare_amount)) OVER (PARTITION BY dc.city_name) AS total_city_revenue
        FROM 
            dim_city dc
        JOIN 
            fact_trips ft ON dc.city_id = ft.city_id
        JOIN 
            dim_date dd ON ft.date = dd.date
        GROUP BY 
            dc.city_name, dd.month_name
    ) AS revenue_data
WHERE 
    total_monthly_revenue = max_revenue;
