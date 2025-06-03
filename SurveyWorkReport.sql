-- report of who updated top containers in the last week
SELECT 
    top_container.last_modified_by, top_container.user_mtime
FROM
    top_container
WHERE
    user_mtime >= DATE_SUB(CURRENT_DATE, INTERVAL 1 WEEK)
ORDER BY top_container.user_mtime DESC
LIMIT 50000;
