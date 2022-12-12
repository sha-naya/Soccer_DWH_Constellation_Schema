DROP TABLE IF EXISTS fct_fixtures CASCADE;

CREATE TABLE fct_fixtures
AS (
WITH
first_merge AS (
SELECT
	l.location_key,
	d.date_key,
	r.referee_key,
	fr."teams.home.name",
	fr."teams.away.name",
	fr."goals.home" AS home_goals,
	fr."goals.away" AS away_goals,
	fr."teams.home.winner" AS home_team_win,
	fr."teams.away.winner" AS away_team_win,
	fr."goals.home" + fr."goals.away" AS total_goals
FROM fixtures_raw_new AS fr
LEFT JOIN dim_location AS l
	ON fr."fixture.venue.name" = l.venue_name
LEFT JOIN dim_date AS d
	ON fr."fixture.date" = d.og_datetime
LEFT JOIN dim_referee AS r
	ON fr."fixture.referee" = r.referee
),
home_team_merge AS (
SELECT
	fm.location_key,
	fm.date_key,
	fm.referee_key,
	dt.team_key AS home_team_key,
	fm."teams.away.name",
	fm.home_goals,
	fm.away_goals,
	fm.home_team_win,
	fm.away_team_win,
	fm.total_goals
FROM first_merge AS fm
LEFT JOIN dim_team AS dt
	ON fm."teams.home.name" = dt.team_name
),
away_team_merge AS (
SELECT
	ROW_NUMBER() OVER() AS fixture_key,
	htm.location_key,
	htm.date_key,
	htm.referee_key,
	htm.home_team_key,
	dt.team_key AS away_team_key,
	htm.home_goals,
	htm.away_goals,
	htm.home_team_win,
	htm.away_team_win,
	htm.total_goals
FROM home_team_merge AS htm
LEFT JOIN dim_team AS dt
	ON htm."teams.away.name" = dt.team_name
)
SELECT *
FROM away_team_merge
);