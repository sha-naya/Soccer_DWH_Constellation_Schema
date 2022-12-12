INSERT INTO dim_transfer_date
WITH
except_table AS (
SELECT
	date,
	datetime,
	year,
	month,
	day
FROM public.stg_transfer_date
EXCEPT
SELECT
	date,
	datetime,
	year,
	month,
	day
FROM public.dim_transfer_date
),
new_location_keys AS (
SELECT
	ROW_NUMBER() OVER() + (SELECT MAX(transfer_date_key) FROM public.dim_transfer_date) AS transfer_date_key,
	*
FROM except_table
)
SELECT *
FROM new_location_keys
;