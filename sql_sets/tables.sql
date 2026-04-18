-- Create and use DB
CREATE DATABASE boardgame_aficionados_db;
USE boardgame_aficionados_db;

-- user_id is everywhere, so we'll start with user
CREATE TABLE user (
    id           INT PRIMARY KEY,
    username     VARCHAR(20) NOT NULL,
    display_name VARCHAR(30),
    password     VARCHAR(25) NOT NULL
);

-- All statistics default to 0 to prevent any NULL issues when comparing for the leaderboard

-- The overall scores per user
CREATE TABLE user_scores (
    user_id INT PRIMARY KEY,
    wins    INT DEFAULT 0,
    losses  INT DEFAULT 0,
    ratio   FLOAT DEFAULT 0,

    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Stats related to Battleship
CREATE TABLE battleship (
    user_id      INT PRIMARY KEY,
    wins         INT DEFAULT 0,
    losses       INT DEFAULT 0,
    ratio        FLOAT DEFAULT 0,
    ships_sunk   INT DEFAULT 0,
    shots_hit    INT DEFAULT 0,
    shots_missed INT DEFAULT 0,
    total_shots  INT DEFAULT 0,

    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Stats related to Blackjack
CREATE TABLE blackjack (
    user_id INT PRIMARY KEY,
    wins    INT DEFAULT 0,
    losses  INT DEFAULT 0,
    ratio   FLOAT DEFAULT 0,
    hits    INT DEFAULT 0,
    stands  INT DEFAULT 0,

    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Stats related to Connect 4
CREATE TABLE connect_four (
    user_id       INT PRIMARY KEY,
    wins          INT DEFAULT 0,
    losses        INT DEFAULT 0,
    ratio         FLOAT DEFAULT 0,
    red_pieces    INT DEFAULT 0,
    yellow_pieces INT DEFAULT 0,
    total_pieces  INT DEFAULT 0,

    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- The game table stores id, a foreign key in tutorial, so we make it first

-- Stores game's id, display name, and "safe" name
CREATE TABLE game (
    id           INT PRIMARY KEY,
    display_name VARCHAR(50) NOT NULL,
    game_name    VARCHAR(75) NOT NULL
);

-- Stores steps in a tutorial for games
CREATE TABLE tutorial (
    game_id     INT,
    step        INT,
    instruction TEXT,

    PRIMARY KEY (game_id, step),
    FOREIGN KEY (game_id) REFERENCES game(id)
);