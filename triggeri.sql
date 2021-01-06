-- Trigger LMD la nivel de comanda
-- Modificarea tabelei series nu se poate fi realizata decat de userul c##claudia,
-- in intervalul Luni - Vineri intre orele 8 - 20.
ALTER TRIGGER modificare_serial ENABLE;

CREATE OR REPLACE TRIGGER modificare_serial
    BEFORE INSERT OR UPDATE OR DELETE ON series
BEGIN
    IF UPPER(SYS.LOGIN_USER) <> 'C##CLAUDIA' THEN
        RAISE_APPLICATION_ERROR(-20008, 'Nu aveti dreptul de a modifica acest tabel');
    ELSIF TO_CHAR(SYSTIMESTAMP, 'D') IN (1, 7) THEN
        RAISE_APPLICATION_ERROR(-20009, 'Nu se poate modifica tabelul in zilele de weekend'); 
    ELSIF TO_CHAR(SYSTIMESTAMP,'HH24') NOT BETWEEN 8 AND 20 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Nu se poate modifica tabelul in afara intervalului 8 - 20');
    END IF;
END;
/

-- 20:59 => nu merge
INSERT INTO series
VALUES (8, 'Nikita', 'A rogue assassin returns to take down the secret organization that trained her.',
        7.7, TO_DATE('9-Sep-2010', 'DD MONTH YYYY'), TO_DATE('27-Dec-2013', 'DD MONTH YYYY'), genres('Action', 'Crime', 'Drama'));

-- sambata => nu merge
INSERT INTO series
VALUES (8, 'Nikita', 'A rogue assassin returns to take down the secret organization that trained her.',
        7.7, TO_DATE('9-Sep-2010', 'DD MONTH YYYY'), TO_DATE('27-Dec-2013', 'DD MONTH YYYY'), genres('Action', 'Crime', 'Drama'));

-- alt user => nu merge
INSERT INTO series
VALUES (8, 'Nikita', 'A rogue assassin returns to take down the secret organization that trained her.',
        7.7, TO_DATE('9-Sep-2010', 'DD MONTH YYYY'), TO_DATE('27-Dec-2013', 'DD MONTH YYYY'), genres('Action', 'Crime', 'Drama'));

ALTER TRIGGER modificare_serial DISABLE;


-- Trigger LMD la nivel de linie
-- Un serial nu poate sa aiba mai mult de 4 episoade

-- creare copie a tabelului episodes
CREATE TABLE episodes_cpy
AS SELECT * FROM episodes;
                     
-- functie care returneaza nr de episoade ale unui sezon
CREATE OR REPLACE FUNCTION nr_episoade_serial
    (id_sez seasons.season_id%TYPE)
RETURN NUMBER IS
    nr_ep NUMBER(1);
BEGIN
    SELECT COUNT(*) INTO nr_ep
    FROM episodes_cpy JOIN seasons USING(season_id)
                      JOIN series USING(series_id)
    WHERE series_id = (SELECT series_id
                       FROM seasons
                       WHERE season_id = id_sez);
    
    RETURN nr_ep;
END;
/

-- creare trigger
ALTER TRIGGER modificare_episodes ENABLE;

CREATE OR REPLACE TRIGGER modificare_episodes
    BEFORE INSERT OR UPDATE on episodes
    FOR EACH ROW
BEGIN
    IF nr_episoade_serial(:NEW.season_id) = 4 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Un serial nu poate avea mai mult de 4 episoade');
    END IF;
END;
/

-- trigger care actualizeaza tabela episodes_cpy
ALTER TRIGGER actualizare_episodes_cpy ENABLE;

CREATE OR REPLACE TRIGGER actualizare_episodes_cpy
    AFTER INSERT OR UPDATE OR DELETE ON episodes
    FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        INSERT INTO episodes_cpy
        VALUES (:NEW.episode_id, :NEW.episode_number, :NEW.title, :NEW.description, 
                :NEW.minutes, :NEW.airing_date, :NEW.rating, :NEW.season_id);        
    ELSIF UPDATING THEN
        UPDATE episodes_cpy
        SET episode_number = :NEW.episode_number, 
            title = :NEW.title, 
            description = :NEW.description, 
            minutes = :NEW.minutes, 
            airing_date = :NEW.airing_date, 
            rating = :NEW.rating, 
            season_id = :NEW.season_id
        WHERE episode_id = :OLD.episode_id;
    ELSE
        DELETE FROM episodes_cpy
        WHERE episode_id = :OLD.episode_id;
    END IF;
END;
/

-- serialul are doar 3 episoade => merge
INSERT INTO episodes
VALUES (19, 19, 'No More Heartbreaks', 'Everyone joins together in an attempt to save Cami''s life.',
        41, '29-APR-2016', 9.3, 6);
        
-- serialul are deja 4 episoade => nu merge
INSERT INTO episodes
VALUES (20, 11, 'Wild at Heart', 'Elijah learns that Aya might have knowlege about an elusive weapon that can take down Original Vampire for good. Davina receives a tempting offer which brings closer to reuniting Kol.',
        42, '05-FEB-2016', 8.6, 6);
        
-- serialul are deja 4 episoade => nu merge
UPDATE episodes
SET season_id = 6
WHERE episode_id = 7;

SELECT * 
FROM episodes JOIN seasons USING (season_id)
WHERE series_id = 3;

-- serialul are doar 3 episoade, deci nu merg inserate alte 3 => nu merge
CREATE SEQUENCE sec_episodes
START WITH 20
INCREMENT BY 1;

BEGIN
    FOR i IN 1..5 LOOP
        INSERT INTO episodes
        VALUES (sec_episodes.NEXTVAL, 2, 'Sara', 'Team Arrow is in pursuit of a new villain who poses a threat to Starling City. Meanwhile, Oliver is worried about not having heard from Thea.',
                42, '15-OCT-2014', 8.5, 8);
    END LOOP;
END;
/

DROP SEQUENCE sec_episodes;

SELECT * 
FROM episodes JOIN seasons USING (season_id)
WHERE series_id = 4;

DELETE FROM episodes
WHERE episode_id = 19;

ALTER TRIGGER modificare_episodes DISABLE;
ALTER TRIGGER actualizare_episodes_cpy DISABLE;


-- Trigger LDD 
-- Pentru fiecare comanda LDD efectuata sa se insereze in tabela istoric_comenzi
-- numele comenzii, obiectul asupra careia a fost egectuata, data efectuarii si
-- utilizatorul ce a efectuat comanda

-- creare tabel istoric_comenzi
CREATE TABLE istoric_comenzi
    (id NUMBER(3) PRIMARY KEY,
     comanda VARCHAR2(20),
     obiect VARCHAR2(30),
     utilizator VARCHAR2(30),
     data TIMESTAMP);
     
-- creare secventa
CREATE SEQUENCE sec_istoric_comenzi
START WITH 1
INCREMENT BY 1;

-- creare trigger
ALTER TRIGGER comenzi_ldd ENABLE;

CREATE OR REPLACE TRIGGER comenzi_ldd
    AFTER CREATE OR ALTER OR DROP ON SCHEMA
BEGIN
    INSERT INTO istoric_comenzi
    VALUES (sec_istoric_comenzi.NEXTVAL, SYS.SYSEVENT, SYS.DICTIONARY_OBJ_NAME, SYS.LOGIN_USER, SYSTIMESTAMP);
END;
/

CREATE TABLE test
    (id NUMBER(2) PRIMARY KEY,
     text VARCHAR2(30));
     
ALTER TABLE test
ADD numar NUMBER(3);

ALTER TABLE test
MODIFY text VARCHAR2(50);

DROP TABLE test;

SELECT * FROM istoric_comenzi;

ALTER TRIGGER comenzi_ldd DISABLE;