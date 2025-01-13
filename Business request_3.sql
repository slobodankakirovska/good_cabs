USE trips_db;

SELECT 
    dc.city_name,
    SUM(CASE WHEN drt.trip_count = 2 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `2-Trips`,
    SUM(CASE WHEN drt.trip_count = 3 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `3-Trips`,
    SUM(CASE WHEN drt.trip_count = 4 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `4-Trips`,
    SUM(CASE WHEN drt.trip_count = 5 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `5-Trips`,
    SUM(CASE WHEN drt.trip_count = 6 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `6-Trips`,
    SUM(CASE WHEN drt.trip_count = 7 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `7-Trips`,
    SUM(CASE WHEN drt.trip_count = 8 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `8-Trips`,
    SUM(CASE WHEN drt.trip_count = 9 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `9-Trips`,
    SUM(CASE WHEN drt.trip_count = 10 THEN drt.repeat_passenger_count ELSE 0 END) * 100.0 / SUM(drt.repeat_passenger_count) AS `10-Trips`
FROM 
    dim_city dc
JOIN 
    dim_repeat_trip_distribution drt ON dc.city_id = drt.city_id
GROUP BY 
    dc.city_name;
