-- Identifies archival objects that have more than one top container associated
SELECT 
    r.id AS resource,
    ao.id AS aoid,
    tc.id AS tcid,
    tc.indicator AS top_indicator,
    ev.value AS sub_indicator_type,
    sc.indicator_2 AS sub_indicator,
    ev2.value AS sub_indicator_type,
    sc.indicator_3 AS sub_indicator
FROM
    resource r
        LEFT JOIN
    archival_object ao ON ao.root_record_id = r.id
        LEFT JOIN
    instance i ON i.archival_object_id = ao.id
        LEFT JOIN
    sub_container sc ON i.id = sc.instance_id
        LEFT JOIN
    top_container_link_rlshp top_to_sub ON sc.id = top_to_sub.sub_container_id
        LEFT JOIN
    top_container tc ON tc.id = top_to_sub.top_container_id
        LEFT JOIN
    enumeration_value ev ON sc.type_2_id = ev.id
        LEFT JOIN
    enumeration_value ev2 ON sc.type_3_id = ev2.id
WHERE
    tc.id IS NOT NULL
GROUP BY ao.id
HAVING COUNT(ao.id) > 1
