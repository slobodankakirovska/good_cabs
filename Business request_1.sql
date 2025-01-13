-- Selecting the correct database
USE trips_db;

-- Query for City-Level Fare and Trip Summary Report
SELECT 
    dc.city_name,
    COUNT(ft.trip_id) AS total_trips,
    AVG(ft.fare_amount / ft.distance_travelled_km) AS avg_fare_per_km,
    AVG(ft.fare_amount) AS avg_fare_per_trip,
    (COUNT(ft.trip_id) / (SELECT COUNT(*) FROM fact_trips)) * 100 AS percentage_contribution_to_total_trips
FROM 
    dim_city dc
JOIN 
    fact_trips ft ON dc.city_id = ft.city_id
GROUP BY 
    dc.city_name;

