-- defender with most tackels

select player_name, team_name, position, tackles
from epl_dataset
where position = 'Defender'
order by tackles desc limit 10;


-- players with tackles won

select player_name, team_name, position, tacklesWon
from epl_dataset
where position = 'Defender'
order by tacklesWon desc limit 10;


-- players with most tackles won per

select player_name, team_name, position, round(tacklesWonPercentage,2) as tacklesWonPercentage
from epl_dataset
where position = 'Defender' AND matchesStarted >= 16
order by tacklesWonPercentage desc limit 10;


-- players with most duels won per

select player_name, team_name, position, totalDuelsWon
from epl_dataset
where position = 'Defender' AND matchesStarted >= 16
order by totalDuelsWon desc limit 10;


-- players with most total Duels Won Percentage per

select player_name, team_name, position, totalDuelsWonPercentage
from epl_dataset
where position = 'Defender' AND matchesStarted >= 16
order by totalDuelsWonPercentage desc limit 10;


-- players with most total Duels Won Percentage per

select player_name, team_name, position, duelLost
from epl_dataset
where position = 'Defender' AND matchesStarted >= 16
order by duelLost desc limit 10;