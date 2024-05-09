SELECT 
    CONCAT('https://archivessearch.lib.uconn.edu/staff/locations/',
            id) AS uri,
    floor,
    coordinate_1_label,
    CONVERT( coordinate_1_indicator , UNSIGNED) AS aisle_num,
    coordinate_2_label,
    coordinate_2_indicator,
    coordinate_3_label,
    coordinate_3_indicator,
    barcode
FROM
    location
WHERE
    floor = 2
        AND coordinate_1_indicator < 11
        AND coordinate_1_label LIKE 'Aisle'
        AND coordinate_2_label LIKE 'Unit'
        AND coordinate_3_label LIKE 'Shelf'
ORDER BY aisle_num , coordinate_2_indicator , coordinate_3_indicator ASC
