INSERT INTO dim_date
WITH
except_table AS (
SELECT
	og_datetime,
	datetime,
	year,
	month,
	day,
	hour,
	minute,
	second,
	date,
	time,
	timezone
FROM public.stg_date
EXCEPT
SELECT
	og_datetime,
	datetime,
	year,
	month,
	day,
	hour,
	minute,
	second,
	date,
	time,
	timezone
FROM public.dim_date
),
new_location_keys AS (
SELECT
	ROW_NUMBER() OVER() + (SELECT MAX(date_key) FROM public.dim_date) AS date_key,
	*
FROM except_table
)
SELECT *
FROM new_location_keys
;