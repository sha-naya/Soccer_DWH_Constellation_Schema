DELETE FROM public.dim_location
WHERE location_key IN (
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
	FROM public.dim_location
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
	FROM public.stg_location
	),
	join_table AS (
	SELECT location_key
	FROM except_table
	LEFT JOIN public.dim_location
	USING (venue_name)
	)
	SELECT *
	FROM join_table
)
;
