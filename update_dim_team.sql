ALTER TABLE dim_team
ADD "2022_status" text;

INSERT INTO dim_team
WITH
except_table AS (
SELECT
	team_name,
	league_name,
	league_country,
	team_logo_url,
	tm_api_club_id,
	"2017_status",
	"2018_status",
	"2019_status",
	"2020_status",
	"2021_status",
	"2022_status"
FROM public.stg_team_final
EXCEPT
SELECT
	team_name,
	league_name,
	league_country,
	team_logo_url,
	tm_api_club_id,
	"2017_status",
	"2018_status",
	"2019_status",
	"2020_status",
	"2021_status",
	NULL AS "2022_status"
FROM public.dim_team
),
new_location_keys AS (
SELECT
	ROW_NUMBER() OVER() + (SELECT MAX(team_key) FROM public.dim_team) AS team_key,
	*
FROM except_table
)
SELECT * 
FROM new_location_keys
;