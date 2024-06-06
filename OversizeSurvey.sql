-- survey of oversize materials. Looks for text "OS' in indicator

SELECT 
    CONCAT('https://archivessearch.lib.uconn.edu/staff/locations/',
            loc.id) AS 'location uri',
    CONCAT('Floor ',
            loc.floor,
            ' ',
            COALESCE(loc.coordinate_1_label, ''),
            ' ',
            COALESCE(loc.coordinate_1_indicator, ''),
            ' ',
            COALESCE(loc.coordinate_2_label, ''),
            ' ',
            COALESCE(loc.coordinate_2_indicator, ''),
            ' ',
            COALESCE(loc.coordinate_3_label, ''),
            ' ',
            COALESCE(loc.coordinate_3_indicator, '')) AS 'location',
    CONCAT('https://archivessearch.lib.uconn.edu/staff/top_containers/',
            tc.id,
            '/edit') AS 'top container uri',
    tc.indicator,
    tc.barcode,
    ao.title AS 'object title',
    CONCAT('https://archivessearch.lib.uconn.edu/staff/resources/',
            r.id,
            '#tree::archival_object_',
            ao.id,
            '/edit') AS 'archival object uri',
    r.title AS 'collection title',
    a.title AS 'accession title',
    CONCAT('https://archivessearch.lib.uconn.edu/staff/accessions/',
            a.id,
            '/edit') AS 'accession uri'
FROM
    top_container tc
        LEFT JOIN
    top_container_housed_at_rlshp tchr ON tchr.top_container_id = tc.id
        LEFT JOIN
    location loc ON loc.id = tchr.location_id
        LEFT JOIN
    top_container_link_rlshp tclr ON tclr.top_container_id = tc.id
        LEFT JOIN
    sub_container sc ON sc.id = tclr.sub_container_id
        LEFT JOIN
    instance i ON sc.instance_id = i.id
        LEFT JOIN
    archival_object ao ON i.archival_object_id = ao.id
        LEFT JOIN
    resource r ON r.id = ao.root_record_id
        LEFT JOIN
    accession a ON a.id = i.accession_id
WHERE
    indicator LIKE '%OS%'
        AND location_id IS NOT NULL
ORDER BY loc.floor , loc.coordinate_1_indicator , loc.coordinate_2_indicator , loc.coordinate_3_indicator
