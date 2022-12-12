INSERT INTO dim_details
WITH
except_table AS (
SELECT
	player_name,
	"to/from_club_name",
	transfer_type,
	tm_api_club_id_origin::bigint
FROM public.stg_details
EXCEPT
SELECT
	player_name,
	"to/from_club_name",
	transfer_type,
	tm_api_club_id_origin
FROM public.dim_details
),
new_location_keys AS (
SELECT
	ROW_NUMBER() OVER() + (SELECT MAX(details_key) FROM public.dim_details) AS details_key,
	*
FROM except_table
)
SELECT *
FROM new_location_keys
;