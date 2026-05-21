-- Finishing Efficiency

SELECT player_name, goals, expectedGoals,
       ROUND(goals - expectedGoals,2) AS finishing_diff
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
WHERE totalShots > 15 and position  = "Forward"
ORDER BY shot_efficiency DESC
LIMIT 10;

-- players with most of there shots got blocked

select player_name, team_name, blockedShots
from epl_dataset
order by blockedShots desc limit 10;


-- top scoarer of each team 

SELECT team_name, player_name, goals
FROM (
    SELECT team_name, player_name, goals,
           RANK() OVER (PARTITION BY team_name ORDER BY goals DESC) AS rnk
    FROM epl_dataset
    where position = 'Forward'
) t
WHERE rnk = 1
order by goals desc;


-- most ammount of heafedgoals

select player_name, team_name, sum(headedGoals) as total_headedgoals
from epl_dataset
GROUP BY player_name, team_name
ORDER BY total_headedgoals DESC LIMIT 10;
 
 
SELECT player_name, goals, team_name, goalConversionPercentage
FROM ( 
    SELECT player_name, goals, team_name, goalConversionPercentage,
           ROW_NUMBER() OVER (PARTITION BY team_name ORDER BY goalConversionPercentage DESC) AS rnk
    FROM epl_dataset
    WHERE position IN ('Forward')
      AND goals > 5
) t
WHERE rnk = 1
ORDER BY goalConversionPercentage DESC;



-- most shots from inside of the box

select player_name, team_name, goalsFromInsideTheBox
from (
select player_name, team_name, goalsFromInsideTheBox,
rank () over (partition by team_name order by goalsFromInsideTheBox desc) as rnk
from epl_dataset
where position = 'Forward'
) t
where rnk = 1
order by goalsFromInsideTheBox desc;



-- most shots from outside of the box

select player_name, team_name, goalsFromOutsideTheBox
from (
select player_name, team_name, goalsFromOutsideTheBox,
rank () over (partition by team_name order by goalsFromOutsideTheBox desc) as rnk
from epl_dataset
where position = 'Forward'
) t
where rnk = 1
order by goalsFromOutsideTheBox desc;



-- top forward players by rating 

select player_name, team_name, rating
from epl_dataset
where position = 'Forward'
order by rating desc limit 10;


 -- top forward player scoring Frequency by munuts

SELECT player_name,
       goals,
       minutesPlayed,
       ROUND(minutesPlayed / NULLIF(goals, 0), 2) AS scoring_frequency
FROM epl_dataset
WHERE position = 'Forward'
ORDER BY scoring_frequency ASC;