USE boardgame_aficionados_db;

-- Users
INSERT INTO user VALUES
(1,  'vjbrazier', 'Vincent', '***'),
(2,  'banana',    'Taylor',  '***'),
(3,  'overlord',  'David',   '***'),
(4,  'hogrider',  'Logan',   '***'),
(5,  'kicker',    'Matt',    '***'),
(6,  'nothing',   'Mike',    '***'),
(7,  'alaire',    'Nikki',   '***'),
(8,  'dat',       'Oryan',   '***'),
(9,  'king88',    'Phil',    '***'),
(10, 'moon',      'Sheldon', '***');

-- Overall scores
INSERT INTO user_scores VALUES 
(1,  18, 12, 1.50),
(2,  12, 18, 0.67),
(3,  11, 9,  1.22),
(4,  24, 16, 1.50),
(5,  7,  13, 0.54),
(6,  15, 5,  3.00),
(8,  10, 21, 0.48),
(9,  18, 6,  3.00),
(10, 5,  15, 0.33);
INSERT INTO user_scores(user_id) VALUES (7);

-- Battleship
INSERT INTO battleship VALUES 
(1,  6,  4,  1.50, 14, 42,  33, 75),
(2,  4,  6,  0.67, 10, 35,  41, 76),
(3,	 4,	 3,	 1.33, 18, 52,  41, 93),
(4,	 8,	 4,	 2,    34, 96,  70, 166),
(5,	 1,	 10, 0.10, 5,  21,  88, 109),
(6,	 2,	 0,	 2,    10, 28,  12, 40),
(8,	 5,	 7,	 0.71, 22, 61,  73, 134),
(9,	 12, 2,	 6,	   51, 140, 60, 200),
(10, 5,	 0,	 5,	   25, 70,  20, 90);
INSERT INTO battleship(user_id) VALUES (7);

-- Blackjack
INSERT INTO blackjack VALUES
(1,  7, 5,  1.40, 29, 18),
(2,  5, 7,  0.71, 21, 24),
(3,  4, 3,  1.33, 18, 22),
(4,  8, 4,  2,    30, 38),
(5,  3, 2,  1.50, 14, 16),
(6,  3, 5,  0.60, 22, 15),
(8,  3, 10, 0.30, 40, 18),
(9,  4, 4,  1,    20, 20),
(10, 0, 10, 0,    35, 5);
INSERT INTO blackjack(user_id) VALUES (7);

-- Connect 4
INSERT INTO connect_four VALUES
(1,  5,  3, 1.67, 58,  53,  111),
(2,  3,  5, 0.60, 49,  56,  105),
(3,	 3,	 3,	1,	  60,  58,	118),
(4,	 8,	 8,	1,	  150, 148, 298),
(5,	 3,	 1,	3,	  70,  62,	132),
(6,	 10, 0,	10,	  210, 180, 390),
(8,	 2,	 4,	0.50, 65,  72,	137),
(9,	 2,	 0,	2,	  50,  40,	90),
(10, 0,	 5,	0,	  55,  80,	135);
INSERT INTO connect_four(user_id) VALUES (7);

-- Game
INSERT INTO game VALUES
(1,	 'Battleship', 'battleship'),
(2,	 'Blackjack',  'blackjack'),
(3,	 'Connect 4',  'connect_four'),
(4,	 'Monopoly',   'monopoly'),
(5,	 'Uno',        'uno'),
(6,	 'Trouble',	   'trouble'),
(7,	 'Yahtzee',	   'yahtzee'),
(8,	 'Chess',	   'chess'),
(9,	 'Checkers',   'checkers'),
(10, 'Phase 10',   'phase_ten');

-- Tutorials
INSERT INTO tutorial VALUES
(1,	1,	'Each player places ships of fixed lengths on their hidden grid (horizontal or vertical, no overlap).'),
(1,	2,	'Players alternate calling a coordinate (e.g., B5) to attack.'),
(1,	3,	'Opponent responds “hit,” “miss,” or “sunk” (when all parts of a ship are hit).'),
(1,	4,	'Mark results and continue taking turns.'),
(1,	5,	'First player to sink all enemy ships wins.'),
(2,	1,	'Each player and the dealer receive two cards (players’ cards visible, dealer has one hidden).'),
(2,	2,	'Players take turns choosing to “hit” (draw a card) or “stand” (keep current hand).'),
(2,	3,	'If a hand exceeds 21, that player busts and loses.'),
(2,	4,	'After players finish, dealer draws until reaching at least 17.'),
(2,	5,	'Hands are compared; highest value ≤21 wins (tie = push).'),
(3,	1,	'Players take turns dropping one piece into any column of the vertical grid.'),
(3,	2,	'The piece falls to the lowest available space in that column.'),
(3,	3,	'Players alternate turns, building lines of their color.'),
(3,	4,	'First player to connect four in a row (horizontal, vertical, or diagonal) wins.'),
(3,	5,	'If the grid fills with no connection, the game is a draw.');