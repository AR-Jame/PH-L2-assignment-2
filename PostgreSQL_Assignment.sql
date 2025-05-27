
CREATE Table rangers (
--     ranger_id SERIAL PRIMARY KEY,
--     name VARCHAR(80) NOT NULL,
--     region VARCHAR(80) NOT NULL
-- );


CREATE Table species (
--     species_id SERIAL PRIMARY KEY,
--     common_name VARCHAR(80) NOT NULL,
--     scientific_name VARCHAR(120) NOT NULL,
--     discovery_date DATE,
--     conservation_status VARCHAR(50)
-- );

CREATE Table sightings (
--     sighting_id SERIAL PRIMARY KEY,
--     ranger_id INT NOT NULL,
--     species_id INT NOT NULL,
--     sighting_time TIMESTAMP NOT NULL,
--     location VARCHAR(100),
--     notes TEXT,
--     Foreign Key (ranger_id) REFERENCES rangers (ranger_id),
--     Foreign Key (species_id) REFERENCES species (species_id)
-- );

INSERT INTO
    species
VALUES (
        1,
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        2,
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        3,
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        4,
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

INSERT INTO
    sightings (
        sighting_id,
        species_id,
        ranger_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        4,
        1,
        2,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

-- Problem-1:
INSERT INTO rangers VALUES ( 4, 'Derek Fox', 'Coastal Plains' );

-- Problem-2:
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- problem-3:
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- problem-4:
SELECT r.name AS name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
    LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY
    r.name;

-- Problem-5:
SELECT s.common_name AS "common_name"
FROM species s
    LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE
    si.species_id IS NULL;

-- Problem-6:
SELECT sp.common_name, si.sighting_time, r.name
FROM
    sightings si
    JOIN species sp ON si.species_id = sp.species_id
    JOIN rangers r ON si.ranger_id = r.ranger_id
ORDER BY si.sighting_time DESC
LIMIT 2;

-- Problem-7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- Problem-8:
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 5 AND 11  THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 16  THEN 'Afternoon'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 17 AND 20  THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day
FROM sightings;

-- Problem-9
DELETE FROM rangers
WHERE
    ranger_id NOT IN (
        SELECT DISTINCT
            ranger_id
        FROM sightings
    );