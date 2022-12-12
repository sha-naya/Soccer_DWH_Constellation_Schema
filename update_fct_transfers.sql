DROP TABLE IF EXISTS fct_transfers CASCADE;

CREATE TABLE fct_transfers
AS (
WITH
first_merge AS (
SELECT
	ROW_NUMBER() OVER() AS transfer_key,
	tt.transfer_type_key,
	p.position_key,
	d.details_key,
	td.transfer_date_key,
	team.team_key,
	tr."transferFeeUnformatted" AS transfer_fee
FROM transfers_raw_new AS tr
LEFT JOIN dim_transfer_type AS tt
	ON tr.transfer_type = tt.transfer_type
LEFT JOIN dim_position AS p
	ON tr.positionsdetail = p.position
LEFT JOIN dim_details AS d
	ON tr."playerName" = d.player_name
	AND tr."clubName" = d."to/from_club_name"
	AND tr.transfer_type = d.transfer_type
	AND tr.team_id::bigint = d.tm_api_club_id_origin
LEFT JOIN dim_transfer_date AS td
	ON tr.date = td.date
LEFT JOIN dim_team AS team
	ON tr.team_id::double precision = team.tm_api_club_id
)
SELECT *
FROM first_merge
)
;