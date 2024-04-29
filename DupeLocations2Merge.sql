SELECT 
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
    uconn.location
GROUP BY floor , room , area , coordinate_1_label , coordinate_1_indicator , coordinate_2_label , coordinate_2_indicator , coordinate_3_label , coordinate_3_indicator
HAVING COUNT(*) > 1
