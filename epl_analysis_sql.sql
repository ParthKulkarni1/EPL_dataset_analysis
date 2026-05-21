-- top 10 players by goal

select player_name, team_name, goals 
from epl_dataset
order by goals desc
limit 10;

-- top 10 players by assists

select player_name, team_name, assists 
from epl_dataset
order by assists desc
limit 10;


-- total goal+assists

select player_name, team_name, goals, assists, (goals + assists) as goal_assist_total
from epl_dataset
order by goal_assist_total desc limit 10;


-- Finishing Efficiency

SELECT player_name, goals, expectedGoals,
       (goals - expectedGoals) AS finishing_diff
FROM epl_dataset
WHERE expectedGoals IS NOT NULL
and position = "Forward"
ORDER BY finishing_diff DESC
LIMIT 10;

-- shot efficiency

SELECT player_name,
       goals,
       totalShots,
       round(goals * 1.0 / totalShots,2) AS shot_efficiency
FROM epl_dataset
WHERE totalShots > 0 and position  = "Forward"
ORDER BY shot_efficiency DESC
LIMIT 10;

-- defencive score

SELECT player_name,
	   team_name,
       position,
       tacklesWon,
       interceptions,
       (tacklesWon + interceptions) AS defensive_score
FROM epl_dataset
ORDER BY defensive_score DESC
LIMIT 10; 

-- ball recovery 

select player_name, team_name, position, ballRecovery
from epl_dataset
order by ballRecovery desc limit 10;

-- passing score all players 

select player_name, team_name, accuratePassesPercentage, totalPasses, 
round(accuratePassesPercentage/100 * totalPasses,2) as passing_score
from epl_dataset
order by passing_score desc limit 10;


-- passing score midfeilder 

select player_name, team_name, accuratePassesPercentage, totalPasses, 
round(accuratePassesPercentage/100 * totalPasses,2) as passing_score
from epl_dataset
where position = "Midfielder"
order by passing_score desc limit 10; 

-- DRIBLING 

SELECT player_name, team_name,  successfulDribbles
FROM epl_dataset
ORDER BY successfulDribbles DESC
LIMIT 10;


-- total goal scoard by all teams 

SELECT team_name, SUM(goals) AS total_goals
FROM epl_dataset
GROUP BY team_name
ORDER BY total_goals DESC;

-- top scoarer of each team 

SELECT team_name, player_name, goals
FROM (
    SELECT team_name, player_name, goals,
           RANK() OVER (PARTITION BY team_name ORDER BY goals DESC) AS rnk
    FROM epl_dataset
) t
WHERE rnk = 1
order by goals desc;


-- top assistser of each team 

SELECT team_name, player_name, assists
FROM (
    SELECT team_name, player_name, assists,
           RANK() OVER (PARTITION BY team_name ORDER BY assists DESC) AS rnk
    FROM epl_dataset
) t
WHERE rnk = 1
order by assists desc;


-- goal conversion per expgoal

SELECT team_name,
       ROUND(SUM(expectedGoals), 2) AS total_expgoal,
       SUM(goals) AS total_goals,
       ROUND(SUM(expectedGoals) - SUM(goals), 2) AS goal_conversion
FROM epl_dataset
GROUP BY team_name
ORDER BY goal_conversion;


-- total failed attempt on target  

select team_name, 
sum(shotsOnTarget) as total_shots_on_target,
sum(goals) as total_team_goal,
SUM(shotsOnTarget) - SUM(goals) AS shots_not_scored
FROM epl_dataset
GROUP BY team_name
ORDER BY shots_not_scored DESC;


-- goal conversion rate from total shots on target taken

select team_name,
sum(goals) as total_goal,
sum(shotsOnTarget) as total_shots_on_target,
ROUND((SUM(goals) / SUM(shotsOnTarget)) * 100, 2) AS conversion_rate
from epl_dataset
group by team_name
order by conversion_rate desc;

-- goal conversion rate from total shots taken

select team_name,
sum(goals) as total_goal,
sum(totalShots) as total_shots,
ROUND((SUM(goals) / SUM(totalShots)) * 100, 2) AS conversion_rate
from epl_dataset
group by team_name
order by conversion_rate desc;