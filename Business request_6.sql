USE trips_db;

-- Monthly and City-Wide Repeat Passenger Rate
SELECT 
    dc.city_name,
    dd.month_name,
    fps.total_passengers,
    fps.repeat_passengers,
    (fps.repeat_passengers / fps.total_passengers) * 100 AS monthly_repeat_passenger_rate,
    -- City-Wide Repeat Passenger Rate
    (SELECT 
        (SUM(fps2.repeat_passengers) / SUM(fps2.total_passengers)) * 100 
     FROM 
        fact_passenger_summary fps2
     WHERE 
        fps2.city_id = fps.city_id
     GROUP BY 
        fps2.city_id) AS city_repeat_passenger_rate
FROM 
    fact_passenger_summary fps
JOIN 
    dim_city dc ON fps.city_id = dc.city_id
JOIN 
    dim_date dd ON fps.month = dd.start_of_month;
