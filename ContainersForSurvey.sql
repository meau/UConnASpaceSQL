SELECT 
    '',
    floor,
    aisle,
    unit,
    shelf,
    top_container_uri,
    top_container_indicator,
    container_barcode,
    collection_title,
    collection_uri,
    accession_title,
    accession_uri
FROM
    (SELECT 
        CONCAT('https://archivessearch.lib.uconn.edu/staff/locations/', loc.id) AS location_uri,
            loc.floor AS floor,
            LPAD(TRIM(loc.coordinate_1_indicator), 3, 0) AS aisle,
            TRIM(loc.coordinate_2_indicator) AS unit,
            LPAD(TRIM(loc.coordinate_3_indicator), 3, 0) AS shelf,
            CONCAT('https://archivessearch.lib.uconn.edu/staff/top_containers/', tc.id, '/edit') AS top_container_uri,
            tc.indicator AS top_container_indicator,
            tc.barcode AS container_barcode,
            r_ao.title AS collection_title,
            CONCAT('https://archivessearch.lib.uconn.edu/staff/resources/', r_ao.id, '/edit') AS collection_uri,
            a.title AS accession_title,
            CONCAT('https://archivessearch.lib.uconn.edu/staff/accessions/', a.id, '/edit') AS accession_uri
    FROM
        resource r_ao
    LEFT JOIN archival_object ao ON ao.root_record_id = r_ao.id
    LEFT JOIN instance i_ao ON i_ao.archival_object_id = ao.id
    LEFT JOIN sub_container sc_ao ON sc_ao.instance_id = i_ao.id
    LEFT JOIN top_container_link_rlshp tclr_ao ON tclr_ao.sub_container_id = sc_ao.id
    LEFT JOIN top_container tc ON tc.id = tclr_ao.top_container_id
    LEFT JOIN accession a ON i_ao.accession_id = a.id
    LEFT JOIN top_container_housed_at_rlshp tchr ON tchr.top_container_id = tc.id
    LEFT JOIN location loc ON loc.id = tchr.location_id
    WHERE
        loc.coordinate_2_label LIKE 'Unit'
    GROUP BY tc.id UNION ALL SELECT 
        CONCAT('https://archivessearch.lib.uconn.edu/staff/locations/', loc.id) AS location_uri,
            loc.floor AS floor,
            LPAD(TRIM(loc.coordinate_1_indicator), 3, 0) AS aisle,
            TRIM(loc.coordinate_2_indicator) AS unit,
            LPAD(TRIM(loc.coordinate_3_indicator), 3, 0) AS shelf,
            '' AS top_container_uri,
            '' AS top_container_indicator,
            '' AS top_container_barcode,
            '' AS collection_title,
            '' AS collection_uri,
            '' AS accession_title,
            '' AS accession_uri
    FROM
        location loc
    WHERE
        loc.coordinate_2_label LIKE 'Unit') candidates
ORDER BY floor , aisle , unit , shelf
LIMIT 5000 OFFSET 45000
