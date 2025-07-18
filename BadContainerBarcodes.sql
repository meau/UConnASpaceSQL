SELECT 
    CONCAT('https://archivessearch.lib.uconn.edu/staff/top_containers/',
            tc.id,
            '/edit') AS 'container uri',
    CONCAT('Floor ',
            loc.floor,
            ' ',
            loc.coordinate_1_label,
            ' ',
            CONVERT( loc.coordinate_1_indicator , UNSIGNED),
            ' ',
            loc.coordinate_2_label,
            ' ',
            loc.coordinate_2_indicator,
            ' ',
            loc.coordinate_3_label,
            ' ',
            CONVERT( loc.coordinate_3_indicator , UNSIGNED)) AS 'location',
    loc.barcode 'location barcode',
    tc.indicator,
    tc.barcode 'container barcode'
FROM
    top_container tc
        JOIN
    top_container_housed_at_rlshp tchr ON tchr.top_container_id = tc.id
        JOIN
    location loc ON tchr.location_id = loc.id
WHERE
    LENGTH(tc.barcode) != 14
        AND loc.barcode IS NOT NULL
