INSERT INTO dim_location
WITH
except_table AS (
SELECT
	country,
	city,
	address,
	venue_name,
	team_name,
	capacity,
	surface,
	start_date,
	end_date,
	is_current
FROM public.stg_location
EXCEPT
SELECT
	country,
	city,
	address,
	venue_name,
	team_name,
	capacity,
	surface,
	start_date,
	end_date,
	is_current
FROM public.dim_location
),
new_location_keys AS (
SELECT
	ROW_NUMBER() OVER() + (SELECT MAX(location_key) FROM public.dim_location) AS location_key,
	*,
	ROW_NUMBER() OVER() + (SELECT MAX(venue_id) FROM public.dim_location) AS venue_id
FROM except_table
),
groupby AS (
	SELECT
		team_name,
		MAX(venue_id) AS venue_id
	FROM new_location_keys
	GROUP BY 1
),
join2 AS (
SELECT
	j.location_key,
	j.country,
	j.city,
	j.address,
	j.venue_name,
	j.team_name,
	j.capacity,
	j.surface,
	j.start_date,
	j.end_date,
	j.is_current,
	g.venue_id
FROM new_location_keys AS j
LEFT JOIN groupby AS g
USING (team_name)
)
SELECT * FROM join2
;