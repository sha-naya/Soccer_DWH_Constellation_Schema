DELETE FROM public.dim_team
WHERE team_key IN (
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
		NULL AS "2022_status"
	FROM public.dim_team
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
		"2022_status"
	FROM public.stg_team_final
	),
	join_table AS (
	SELECT team_key
	FROM except_table
	LEFT JOIN public.dim_team
	USING (team_name)
	)
	SELECT *
	FROM join_table
)
;
