INSERT INTO dim_referee
WITH
except_table AS (
SELECT
	referee
FROM public.stg_referee
EXCEPT
SELECT
	referee
FROM public.dim_referee
),
new_location_keys AS (
SELECT
	ROW_NUMBER() OVER() + (SELECT MAX(referee_key) FROM public.dim_referee) AS referee_key,
	*
FROM except_table
)
SELECT *
FROM new_location_keys
;