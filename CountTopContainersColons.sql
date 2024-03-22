-- gives a count of how many top containers in the repository have a colon in the indicator. This tends to mean that the box and the folder were smashed into the same field.
SELECT 
    COUNT(*)
FROM
    top_container
WHERE
    indicator LIKE '%:%'
