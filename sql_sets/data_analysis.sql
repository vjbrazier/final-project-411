USE boardgame_aficionados_db;

-- 1. Who are the best players overall?
SELECT u.display_name AS 'Best Players'
FROM user u, user_scores us
WHERE u.id = us.user_id
ORDER BY us.ratio DESC;

-- 2. What players have an overall ratio greater than 1?
SELECT u.display_name AS '>1 Ratio Players'
FROM user u
WHERE u.id IN (
	SELECT us.user_id AS Player
	FROM user_scores us
	WHERE us.ratio > 1
);

-- 3. What are the average wins per game?
SELECT
	(SELECT AVG(ba.wins) 
     FROM battleship ba) AS 'Battleship Average Wins',
    
    (SELECT AVG(bl.wins) 
     FROM blackjack bl) AS 'Blackjack Average Wins',
    
    (SELECT AVG(c.wins) 
     FROM connect_four c) AS 'Connect 4 Average Wins';

-- 4. Which game has the highest win rate? 
SELECT game AS 'Most Won Game', MAX(ratio) AS 'Highest Ratio'
FROM (
    SELECT 'Battleship' AS game, ba.ratio
    FROM battleship ba
    
    UNION

    SELECT 'Blackjack' AS game, bl.ratio 
    FROM blackjack bl
    
    UNION
    
    SELECT 'Connect 4', c.ratio 
    FROM connect_four c
) high_ratios
GROUP BY game
ORDER BY MAX(ratio) DESC
LIMIT 1;

-- 5. Who is the best player per game?
SELECT
    (SELECT u.display_name
    FROM user u
    WHERE u.id IN (
        SELECT ba2.user_id
        FROM battleship ba2
        WHERE ba2.ratio IN (
            SELECT MAX(ba1.ratio)
            FROM battleship ba1
        )
    )) AS 'Best Battleship Player',

    (SELECT u.display_name
    FROM user u
    WHERE u.id IN (
        SELECT bl2.user_id
        FROM blackjack bl2
        WHERE bl2.ratio IN (
            SELECT MAX(bl1.ratio)
            FROM blackjack bl1
        )
    )) AS 'Best Blackjack Player',

    (SELECT u.display_name
    FROM user u
    WHERE u.id IN (
        SELECT c2.user_id
        FROM connect_four c2
        WHERE c2.ratio IN (
            SELECT MAX(c1.ratio)
            FROM connect_four c1
        )
    )) AS 'Best Connect 4 Player';

-- 6. What player likes red the most in Connect 4? 
SELECT u.display_name AS 'Likes Red The Most'
FROM user u
WHERE u.id IN (
    SELECT c2.user_id
    FROM connect_four c2
    WHERE c2.red_pieces IN (
        SELECT MAX(c1.red_pieces)
        FROM connect_four c1
    )
);

-- 7. Based on total matches, what game is played the most?  
SELECT game AS 'Most Played Game', MAX(total_games) AS 'Total Games'
FROM (
    SELECT 'Battleship' AS game, SUM(ba.wins + ba.losses) AS total_games
    FROM battleship ba
    
    UNION

    SELECT 'Blackjack' AS game, SUM(bl.wins + bl.losses) AS total_games 
    FROM blackjack bl
    
    UNION
    
    SELECT 'Connect 4', SUM(c.wins + c.losses) AS total_games
    FROM connect_four c
) high_plays
GROUP BY game
ORDER BY MAX(total_games) DESC
LIMIT 1;

-- 8. What players have never lost in at least one game? 
SELECT u.display_name AS '0 Losses'
FROM user u
WHERE u.id IN (
    SELECT ba.user_id
    FROM battleship ba
    WHERE ba.losses = 0

    UNION

    SELECT bl.user_id
    FROM blackjack bl
    WHERE bl.losses = 0

    UNION

    SELECT c.user_id
    FROM connect_four c
    WHERE c.losses = 0
);

-- 9. Who has hit the most shots in Battleship? 
SELECT u.display_name AS 'Most Shots Hit'
FROM user u
WHERE u.id IN (
    SELECT ba2.user_id
    FROM battleship ba2
    WHERE ba2.shots_hit IN (
        SELECT MAX(ba1.shots_hit)
        FROM battleship ba1
    )
);

-- 10. Who plays the safest in Blackjack? (the most stands)
SELECT u.display_name AS 'Safest Player'
FROM user u
WHERE u.id IN (
    SELECT bl2.user_id
    FROM blackjack bl2
    WHERE bl2.stands IN (
        SELECT MAX(bl1.stands)
        FROM blackjack bl1
    )
);