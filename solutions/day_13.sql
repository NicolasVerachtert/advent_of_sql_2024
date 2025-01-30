WITH
    emails AS (
        SELECT
            UNNEST (email_addresses) AS address
        FROM
            contact_list
    ),
    domains AS (
        SELECT
            address,
            split_part (address, '@', 2) AS subdomain
        FROM
            emails
    ),
    domain_aggregation AS (
        SELECT
            subdomain,
            array_agg (
                address
                ORDER BY
                    address
            ) AS users
        FROM
            domains
        GROUP BY
            subdomain
    )
SELECT
    subdomain AS Domain,
    array_length (users, 1) AS "Total Users",
    users AS Users
FROM
    domain_aggregation
ORDER BY
    "Total Users" DESC