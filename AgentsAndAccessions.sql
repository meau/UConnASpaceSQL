SELECT 
    agent_contact.name,
    agent_contact.address_1,
    agent_contact.address_2,
    agent_contact.address_3,
    agent_contact.city,
    agent_contact.region,
    agent_contact.country,
    agent_contact.post_code,
    agent_contact.email,
    enumeration_value.value 'phone type',
    telephone.number 'phone number',
    accession.display_string 'archives gift title',
    accession.content_description 'archives gift description',
    accession.accession_date 'archives gift date',
    accession.provenance,
    accession.create_time 'archives record date'
FROM
    agent_contact
        JOIN
    agent_person ap ON agent_contact.agent_person_id = ap.id
        LEFT JOIN
    linked_agents_rlshp lar ON lar.agent_person_id = ap.id
        LEFT JOIN
    accession ON accession.id = lar.accession_id
        LEFT JOIN
    telephone ON telephone.agent_contact_id = agent_contact.id
        LEFT JOIN
    enumeration_value ON telephone.number_type_id = enumeration_value.id
WHERE
    (email IS NOT NULL
        OR post_code IS NOT NULL
        OR region IS NOT NULL)
        AND lar.accession_id IS NOT NULL
GROUP BY accession.id , agent_contact.id
ORDER BY accession.create_time DESC
LIMIT 10000
