-- provides a report of which container profiles are present and how frequently they are assigned to top containers

SELECT 
    cp.name,
    COUNT(tcpr.container_profile_id) frequency
FROM
    container_profile cp
        LEFT JOIN
    top_container_profile_rlshp tcpr ON cp.id = tcpr.container_profile_id
GROUP BY tcpr.container_profile_id
ORDER BY frequency desc
