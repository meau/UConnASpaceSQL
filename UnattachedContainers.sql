-- finds top containers that aren't associated with resources, accessions, or archival objects
SELECT 
    *
FROM
    top_container tc
        LEFT JOIN
    top_container_link_rlshp top_to_sub ON tc.id = top_to_sub.top_container_id
        LEFT JOIN
    sub_container sc ON sc.id = top_to_sub.sub_container_id
        LEFT JOIN
    instance i ON i.id = sc.instance_id
WHERE
    sc.instance_id IS NULL
