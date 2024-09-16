SELECT 
    a.*
FROM
    location a
        JOIN
    (SELECT 
        id,
            floor,
            room,
            area,
            coordinate_1_label,
            coordinate_1_indicator,
            coordinate_2_label,
            coordinate_2_indicator,
            coordinate_3_label,
            coordinate_3_indicator,
            COUNT(*)
    FROM
        location loc
    GROUP BY loc.floor , loc.room , loc.area , loc.coordinate_1_label , loc.coordinate_1_indicator , loc.coordinate_2_label , loc.coordinate_2_indicator , loc.coordinate_3_label , loc.coordinate_3_indicator
    HAVING COUNT(*) > 1) b ON a.floor = b.floor
        AND a.coordinate_1_indicator = b.coordinate_1_indicator
        AND a.coordinate_1_label = b.coordinate_1_label
        AND a.coordinate_2_indicator = b.coordinate_2_indicator
        AND a.coordinate_2_label = b.coordinate_2_label
        AND a.coordinate_3_indicator = b.coordinate_3_indicator
        AND a.coordinate_3_label = b.coordinate_3_label
ORDER BY a.floor , a.room , a.area , a.coordinate_1_label , a.coordinate_1_indicator , a.coordinate_2_label , a.coordinate_2_indicator , a.coordinate_3_label , a.coordinate_3_indicator , a.create_time
