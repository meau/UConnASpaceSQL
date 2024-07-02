-- this report identifies arechival objects where the level is set to "collection"

SELECT 
    CONCAT('https://archivessearch.lib.uconn.edu/staff/resources/',
            ao.root_record_id,
            '/edit#tree::archival_object_',
            ao.id) AS URI,
    r.title
FROM
    archival_object ao
        LEFT JOIN
    resource r ON ao.root_record_id = r.id
WHERE
    ao.level_id = 889
;
