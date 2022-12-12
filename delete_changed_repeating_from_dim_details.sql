DELETE FROM public.dim_details
WHERE (player_name, "to/from_club_name", transfer_type, tm_api_club_id_origin) IN (
	WITH
	except_table AS (
	SELECT
		player_name,
		"to/from_club_name",
		transfer_type,
		tm_api_club_id_origin
	FROM public.dim_details
	EXCEPT
	SELECT
		player_name,
		"to/from_club_name",
		transfer_type,
		tm_api_club_id_origin::bigint
	FROM public.stg_details
	)
	SELECT 
		player_name,
		"to/from_club_name",
		transfer_type,
		tm_api_club_id_origin::bigint
	FROM except_table
)
;
