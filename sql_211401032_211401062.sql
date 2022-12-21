-- Query #1
-- Games on steam that support windows, support linux or mac
select(
	select count(*)
	from steam
	where platforms like 'windows%'
	)  as 'games that support windows',
	(
	select count(*)
	from steam
	where platforms like '%linux'
	)  as 'games that support linux',
	(
	select count(*) 
	from steam
	where platforms like '%mac%'
	)as 'games that support mac'
	;
	
-- Query #2
-- Number of singleplayer games, multiplayer games, games that are both and games that support either
select
	(
	select
	count(*)
	from steam s
	where (categories like '%Multi-player%') and (categories not like '%Single-player%')
	)
	as only_multiplayer,
	(
	select
	count(*)
	from steam s
	where (categories like '%Single-player%') and (categories not like '%Multi-player%')
	)
	as only_singleplayer,
	(
	select
	count(*)
	from steam s
	where (categories like '%Single-player%') and (categories like '%Multi-player%')
	)
	as multi_and_single
;

-- Query #3
-- List of developers with the highest number of ratings on their games
select 
	developer,
	sum(positive_ratings + negative_ratings) as ratings
from steam
group by developer
order by ratings desc
;

-- Query #4
--  Number of ratings on singleplayer games, multiplayer games, games that are both and games that support either
select
	(
	select
	sum(positive_ratings+negative_ratings)
	from steam s
	where (categories like '%Multi-player%') and (categories not like '%Single-player%')
	)
	as only_multiplayer,
	(
	select
	sum(positive_ratings+negative_ratings)
	from steam s
	where (categories like '%Single-player%') and (categories not like '%Multi-player%')
	)
	as only_singleplayer,
	(
	select
	sum(positive_ratings+negative_ratings)
	from steam s
	where (categories like '%Single-player%') and (categories like '%Multi-player%')
	)
	as multi_and_single
;

-- Query #5
-- Sum of every game from each developer and average price, sorted by amount of games
select 
	developer,
	count(price),
	avg(price)
from steam
group by developer
order by count(price) desc
;