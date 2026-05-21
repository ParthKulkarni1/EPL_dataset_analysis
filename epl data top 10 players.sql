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


-- top 10 player total goal+assists

select player_name, team_name, goals, assists, (goals + assists) as goal_assist_total
from epl_dataset
order by goal_assist_total desc limit 10;


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


-- successful Dribbles

SELECT player_name, position, team_name,  successfulDribbles
FROM epl_dataset
ORDER BY successfulDribbles DESC
LIMIT 10;


-- top by penalty scoard

select player_name, team_name, penaltyGoals
from epl_dataset
order by penaltyGoals desc limit 10;


-- top by freekick scoard

select player_name, team_name, freeKickGoal
from epl_dataset
order by freeKickGoal desc limit 10;


-- most ammount of minutes played

select player_name, team_name, minutesPlayed
from epl_dataset
order by minutesPlayed desc limit 10;


-- most ammount of matches played

select player_name, team_name, matchesStarted
from epl_dataset
order by matchesStarted desc limit 10;


-- top players by rating 

select player_name, team_name, rating
from epl_dataset
order by rating desc limit 10;

-- top player scoring Frequency by munuts

select player_name, team_name, goals, round(scoringFrequency,2) as scoring_frequency
from epl_dataset
where goals > 10
order by scoring_frequency asc limit 10;


SELECT player_name,
       goals,
       minutesPlayed,
       ROUND(minutesPlayed / NULLIF(goals, 0), 2) AS scoring_frequency
FROM epl_dataset
WHERE goals > 10
ORDER BY scoring_frequency ASC;


-- set piece conversion

select player_name, team_name, setPieceConversion
from epl_dataset
order by setPieceConversion desc limit 10;


-- player with most tackels

select player_name, team_name, tackles
from epl_dataset
order by tackles desc limit 10;


-- players with tackles won

select player_name, team_name, tacklesWon
from epl_dataset
order by tacklesWon desc limit 10;


-- player with most touches 

select player_name, team_name, touches
from epl_dataset
order by touches desc limit 10;

-- player with most yellow cards

select player_name, team_name, yellowCards
from epl_dataset
order by yellowCards desc limit 10;


-- players with most red cards;

select player_name, team_name, redCards
from epl_dataset
order by redCards desc limit 10;