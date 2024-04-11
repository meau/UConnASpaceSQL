-- counts archival objects at "file" or "item" level that don't have associated containers
SELECT 
    COUNT(*)
FROM
    archival_object ao
        LEFT JOIN
    instance i ON ao.id = i.archival_object_id
WHERE
    i.archival_object_id IS NULL
        AND (ao.level_id = 890 OR ao.level_id = 892)
