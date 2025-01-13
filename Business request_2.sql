-- Ensure the correct database is selected
USE trips_db;

-- Query to evaluate target performance with explicit database references
SELECT 
    tdb_dc.city_name,
    tdb_dd.month_name,
    COUNT(ft.trip_id) AS actual_trips,
    tdb_mt.total_target_trips AS target_trips,
    CASE 
        WHEN COUNT(ft.trip_id) > tdb_mt.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    ((COUNT(ft.trip_id) - tdb_mt.total_target_trips) / tdb_mt.total_target_trips) * 100 AS percentage_difference
FROM 
    trips_db.dim_city tdb_dc
JOIN 
    trips_db.fact_trips ft ON tdb_dc.city_id = ft.city_id
JOIN 
    trips_db.dim_date tdb_dd ON ft.date = tdb_dd.date
JOIN 
    targets_db.monthly_target_trips tdb_mt ON tdb_dc.city_id = tdb_mt.city_id AND tdb_dd.start_of_month = tdb_mt.month
GROUP BY 
    tdb_dc.city_name, tdb_dd.month_name, tdb_mt.total_target_trips;
