-- CREARE TABELE
CREATE TABLE producers
    (producer_id NUMBER(3) PRIMARY KEY,
     first_name VARCHAR2(40) NOT NULL,
     last_name VARCHAR2(40) NOT NULL,
     birthdate DATE);

CREATE OR REPLACE TYPE genres IS TABLE OF VARCHAR2(20);
/

CREATE TABLE series
    (series_id NUMBER(3) PRIMARY KEY,
     title VARCHAR2(50) NOT NULL,
     description VARCHAR(300),
     rating NUMBER(2,1),
     starting_date DATE NOT NULL,
     ending_date DATE,
     genre genres,
     CONSTRAINT date_series CHECK (starting_date <= ending_date))
     
NESTED TABLE genre STORE AS genre;

CREATE TABLE produced_by
    (producer_id NUMBER(3) REFERENCES producers(producer_id) ON DELETE CASCADE,
     series_id NUMBER(3) REFERENCES series(series_id) ON DELETE CASCADE,
     PRIMARY KEY(producer_id, series_id));

CREATE TABLE seasons
    (season_id NUMBER(3) PRIMARY KEY,
     season_number NUMBER(2) NOT NULL,
     starting_date DATE,
     ending_date DATE,
     series_id NUMBER(3) REFERENCES series(series_id) ON DELETE CASCADE);
    
CREATE TABLE episodes
    (episode_id NUMBER(3) PRIMARY KEY,
     episode_number NUMBER(3) NOT NULL,
     title VARCHAR2(50) NOT NULL,
     description VARCHAR2 (700),
     minutes NUMBER(3),
     airing_date DATE,
     rating NUMBER(2,1),
     season_id NUMBER(3) REFERENCES seasons(season_id) ON DELETE CASCADE);

CREATE TABLE characters
    (character_id NUMBER(3) PRIMARY KEY,
     first_name VARCHAR2(40) NOT NULL,
     last_name VARCHAR2(40));

CREATE TABLE appearing_in
    (episode_id NUMBER(3) REFERENCES episodes(episode_id) ON DELETE CASCADE,
     character_id NUMBER(3) REFERENCES characters(character_id) ON DELETE CASCADE,
     PRIMARY KEY(episode_id, character_id));
     
CREATE TABLE actors
    (actor_id NUMBER(3) PRIMARY KEY,
     first_name VARCHAR2(40) NOT NULL,
     last_name VARCHAR2(40) NOT NULL,
     birth_date DATE);
     
CREATE TABLE playing
    (series_id NUMBER(3) REFERENCES series(series_id) ON DELETE CASCADE,
     actor_id NUMBER(3) REFERENCES actors(actor_id) ON DELETE CASCADE,
     character_id NUMBER(3) REFERENCES characters(character_id) ON DELETE CASCADE,
     starting_date DATE,
     ending_date DATE,
     episodes_number NUMBER(3),
     PRIMARY KEY(series_id, character_id, actor_id),
     CONSTRAINT date_playing CHECK (starting_date <= ending_date));

DESC producers;
DESC series;
DESC produced_by;
DESC seasons;
DESC episodes;
DESC characters;
DESC appearing_in;
DESC actors;
DESC playing;