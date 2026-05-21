-- top mid players with highest passingpercentage

select player_name, team_name, accuratePasses, round(accuratePassesPercentage,2)
from epl_dataset
where position = 'Midfielder' and matchesStarted > 5
order by accuratePassesPercentage desc limit 10; 



-- passing score midfeilder 

select player_name, team_name, accuratePassesPercentage, totalPasses, 
round(accuratePassesPercentage/100 * totalPasses,2) as passing_score
from epl_dataset
where position = "Midfielder"
order by passing_score desc limit 10; 


-- top assistser of each team 

SELECT team_name, player_name, assists
FROM (
    SELECT team_name, player_name, assists,
           RANK() OVER (PARTITION BY team_name ORDER BY assists DESC) AS rnk
    FROM epl_dataset
    where position = 'Midfielder'
) t
WHERE rnk = 1
order by assists desc;

-- big chances created by a mid player

select player_name, team_name, bigChancesCreated
from epl_dataset
where position = 'Midfielder'
order by bigChancesCreated desc limit 10;


-- -- top mid players by rating 

select player_name, team_name, rating
from epl_dataset
where position = 'Midfielder'
order by rating desc limit 10;

-- highest passing per mid

select player_name, team_name, round(accuratePassesPercentage,2) as accuratePasses_per
from epl_dataset
where matchesStarted > 15
order by accuratePassesPercentage desc limit 10;



-- most key passes

select player_name, team_name, keyPasses
from epl_dataset
order by keyPasses desc limit 10;



