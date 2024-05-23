-- report for shelf read survey
SELECT 
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
            CONVERT( loc.coordinate_3_indicator , UNSIGNED)) as 'location',
    CONCAT('https://archivessearch.lib.uconn.edu/staff/locations/',
            loc.id,
            '/edit') AS 'location uri',
    ev.value,
    tc.indicator
FROM
    location loc
        LEFT JOIN
    uconn.top_container_housed_at_rlshp ON loc.id = top_container_housed_at_rlshp.location_id
        LEFT JOIN
    top_container tc ON top_container_housed_at_rlshp.top_container_id = tc.id
        LEFT JOIN
    enumeration_value ev ON tc.type_id = ev.id

