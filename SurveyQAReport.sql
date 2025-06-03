-- perform quality analysis of all survey updates that have been made
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
            CONVERT( loc.coordinate_3_indicator , UNSIGNED)) AS 'location',
    loc.barcode 'location barcode',
    ev.value,
    tc.indicator,
    tc.barcode 'container barcode',
    cp.name 'container profile',
    tc.last_modified_by,
    tc.user_mtime
FROM
    location loc
        LEFT JOIN
    uconn.top_container_housed_at_rlshp ON loc.id = top_container_housed_at_rlshp.location_id
        LEFT JOIN
    top_container tc ON top_container_housed_at_rlshp.top_container_id = tc.id
        LEFT JOIN
    enumeration_value ev ON tc.type_id = ev.id
        LEFT JOIN
    top_container_profile_rlshp ON tc.id = top_container_profile_rlshp.top_container_id
        LEFT JOIN
    container_profile cp ON cp.id = top_container_profile_rlshp.container_profile_id
WHERE
    tc.user_mtime >= DATE_SUB(CURRENT_DATE, INTERVAL 2 WEEK)
        AND tc.barcode LIKE '%42%'
