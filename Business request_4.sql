use trips_db;

SELECT 
    city_name,
    total_new_passengers,
    CASE 
        WHEN RANK() OVER (ORDER BY total_new_passengers DESC) <= 3 THEN 'Top 3'
        WHEN RANK() OVER (ORDER BY total_new_passengers ASC) <= 3 THEN 'Bottom 3'
        ELSE 'Other'
    END AS city_category
FROM 
    (
        SELECT 
            dc.city_name,
            SUM(fps.new_passengers) AS total_new_passengers
        FROM 
            dim_city dc
        JOIN 
            fact_passenger_summary fps ON dc.city_id = fps.city_id
        GROUP BY 
            dc.city_name
    ) AS ranked_cities;
