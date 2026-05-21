-- total goals conceded by all teams

SELECT team_name,
       count(goalsConceded) AS total_goals_conceded
FROM epl_dataset
GROUP BY team_name
ORDER BY total_goals_conceded ASC;


-- total goals scoard by all teams

SELECT team_name,
       sum(goals) AS total_goals_scoard
FROM epl_dataset
GROUP BY team_name
ORDER BY total_goals_scoard desc;


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


-- teams goal conversion per expgoal

SELECT team_name,
       ROUND(SUM(expectedGoals), 2) AS total_expgoal,
       SUM(goals) AS total_goals,
       ROUND(SUM(expectedGoals) - SUM(goals), 2) AS goal_conversion
FROM epl_dataset
GROUP BY team_name
ORDER BY goal_conversion;


-- teams total failed attempt on target  

select team_name, 
sum(shotsOnTarget) as total_shots_on_target,
sum(goals) as total_team_goal,
SUM(shotsOnTarget) - SUM(goals) AS shots_not_scored
FROM epl_dataset
GROUP BY team_name
ORDER BY shots_not_scored DESC;


-- teams goal conversion rate from total shots on target 

select team_name,
sum(goals) as total_goal,
sum(shotsOnTarget) as total_shots_on_target,
ROUND((SUM(goals) / SUM(shotsOnTarget)) * 100, 2) AS conversion_rate
from epl_dataset
group by team_name
order by conversion_rate desc;

-- teams goal conversion rate from total shots taken

select team_name,
sum(goals) as total_goal,
sum(totalShots) as total_shots,
ROUND((SUM(goals) / SUM(totalShots)) * 100, 2) AS conversion_rate
from epl_dataset
group by team_name
order by conversion_rate desc;


-- most goals conceded by team from inside of the box

select player_name, team_name, goalsConcededInsideTheBox
from (
select player_name, team_name, goalsConcededInsideTheBox,
rank () over (partition by team_name order by goalsConcededInsideTheBox desc) as rnk
from epl_dataset
) t
where rnk = 1
order by goalsConcededInsideTheBox desc;


-- best player of each team byn rating

select player_name, team_name, rating
from (
select player_name, team_name, rating,
rank () over (partition by team_name order by rating desc) as rnk
from epl_dataset
) t
where rnk = 1
order by rating desc;


-- highest player passing per of each team

select player_name, team_name, accuratePassesPercentage
from (
select player_name, team_name, accuratePassesPercentage,
rank () over (partition by team_name order by accuratePassesPercentage desc) as rnk
from epl_dataset
where matchesStarted > 20
) t
where rnk = 1
order by accuratePassesPercentage desc;


-- possession lost by a team

SELECT team_name,
       SUM(possessionLost) AS total_possession_lost,
       SUM(totalPasses) AS total_passes,
       ROUND((SUM(possessionLost) / NULLIF(SUM(totalPasses),0)) * 100, 2) AS loss_rate
FROM epl_dataset
GROUP BY team_name
ORDER BY loss_rate DESC;


-- team with most inaccurate passes persentage

SELECT team_name,
       ROUND(SUM(totalPasses) - SUM(accuratePasses), 2) AS inaccurate_passes,
       ROUND((SUM(totalPasses) - SUM(accuratePasses)) / NULLIF(SUM(totalPasses),0) * 100, 2) AS inaccurate_rate
FROM epl_dataset
GROUP BY team_name
ORDER BY inaccurate_rate DESC;



-- team with most accurate pass persentage

SELECT team_name,
       SUM(accuratePasses) AS total_accurate_passes,
       SUM(totalPasses) AS total_passes,
       ROUND((SUM(accuratePasses) / NULLIF(SUM(totalPasses),0)) * 100, 2) AS team_accuracy
FROM epl_dataset
GROUP BY team_name
ORDER BY team_accuracy DESC;



SELECT team_name,
       ROUND(AVG(rating), 2) AS avg_team_rating
FROM epl_dataset
GROUP BY team_name
ORDER BY avg_team_rating DESC
LIMIT 5;