-- Subprogram stocat care sa foloseasca un tip de colectie
-- Sa se modifice lista de categorii a unui serial specificat:
-- i) adaugarea unei categorii (se da valoarea noii categori plus cuvantul 'INSERTING')
-- ii) stergerea unei categorii (se da valoarea categoriei plus cuvantul 'DELETING')
-- iii) modificarea unei categorii (se da valoarea vechii categorii, noii categori plus cuvantul 'UPDATING')
CREATE OR REPLACE PROCEDURE modificare_categorii
    (serial series.title%TYPE,
     categ1 VARCHAR2,
     optiune VARCHAR2,
     categ2 VARCHAR2 := NULL) 
AS
    categorii genres;
    i INTEGER;
BEGIN
    -- obtinere lista categorii pentru seraialul dat
    SELECT genre INTO categorii
    FROM series
    WHERE title = INITCAP(serial);
    
    IF UPPER(optiune) = 'INSERTING' THEN
        IF categ1 IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Categoria nou introdusa nu poate sa fie NULL');
        ELSE
            -- adaugarea unei categorii noi
            categorii.extend();
            categorii(categorii.last) := INITCAP(categ1); 
        END IF;
    ELSIF UPPER(optiune) = 'DELETING' THEN
        IF categ1 IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Categoria de sters nu poate sa fie NULL');
        ELSE
            -- determinarea pozitiei categoriei ce trebuie stearsa
            i := categorii.FIRST;
            WHILE i <= categorii.LAST AND categorii(i) <> INITCAP(categ1) LOOP
                i := categorii.NEXT(i);
            END LOOP;
            
            IF i IS NOT NULL THEN
                -- stergerea categoriei
                categorii.DELETE(i);
            ELSE
                RAISE_APPLICATION_ERROR(-20002, 'Nu exista categoria introdusa');
            END IF;
        END IF;
    ELSIF UPPER(optiune) = 'UPDATING' THEN
        IF categ1 IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Categoria de actualizat nu poate sa fie NULL');
        ELSE
            IF categ2 IS NULL THEN
                RAISE_APPLICATION_ERROR(-20001, 'Categoria nou introdusa nu poate sa fie NULL');
            ELSE
                -- determinarea pozitiei categoriei ce trebuie modificata
                i := categorii.FIRST;
                WHILE i <= categorii.LAST AND categorii(i) <> INITCAP(categ1) LOOP
                    i := categorii.NEXT(i);
                END LOOP;
                
                IF i IS NOT NULL THEN
                    -- odificarea categoriei
                    categorii(i) := INITCAP(categ2);
                ELSE
                    RAISE_APPLICATION_ERROR(-20002, 'Nu exista categoria introdusa');
                END IF; 
            END IF;
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'Optiunea introdusa este gresita');
    END IF;
    
    -- actualizare lista categorii
    UPDATE series
    SET genre = categorii
    WHERE title = serial;
    
    DBMS_OUTPUT.PUT_LINE('Lista de categorii a fost actualizata cu succes');
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20004, 'Nu exista serial cu numele dat');
    WHEN too_many_rows THEN
        RAISE_APPLICATION_ERROR(-20005, 'Exista mai multe seriale cu acest nume');
END;
/

SELECT *
FROM series
WHERE title = 'The Magicians';

-- merge
EXECUTE modificare_categorii('The Magicians', 'HORROR', 'inserting');

-- eroare: categoria de inserat nu poate fi null
EXECUTE modificare_categorii('The Magicians', null, 'inserting');

-- merge
EXECUTE modificare_categorii('The Magicians', 'horror', 'deleting');


SELECT *
FROM series
WHERE title = 'Supernatural';

-- merge
EXECUTE modificare_categorii('Supernatural', 'Drama', 'deleting');

-- eroare: nu exista categoria
EXECUTE modificare_categorii('Supernatural', 'Action', 'deleting');

-- eroare: categoria de sters nu poate fi null
EXECUTE modificare_categorii('Supernatural', null, 'deleting');

-- merge
EXECUTE modificare_categorii('Supernatural', 'Drama', 'inserting');


SELECT *
FROM series
WHERE title = 'Arrow';

-- eroare: categoria cu care se inlocuieste nu poate fi null
EXECUTE modificare_categorii('Arrow', 'Action', 'updating');

-- merge
EXECUTE modificare_categorii('Arrow', 'Action', 'updating', 'Drama');

-- eroare: categoria de inlocuit nu poate fi null
EXECUTE modificare_categorii('Arrow', null, 'updating', 'Drama');

-- eroare: nu exista categoria de modificat
EXECUTE modificare_categorii('Arrow', 'Thriller', 'updating', 'Drama');

-- merge
EXECUTE modificare_categorii('Arrow', 'Drama', 'updating', 'Action');


-- eroare: comanda invalida
EXECUTE modificare_categorii('Arrow', 'Drama', 'insert');


-- Subprogram stocat care sa utilizeze un tip de cursor
-- Sa se afiseze toate sezoanele si episoadele unui serial specificat
-- sezon: numar, data inceput, data sfarsit
-- episod: numar, nume, descriere, rating
CREATE OR REPLACE PROCEDURE afisare_episoade 
    (serial series.title%TYPE)
AS
    TYPE ref_cursor IS REF CURSOR;
    CURSOR sezoane (id_serial NUMBER) IS
        SELECT season_number, starting_date, ending_date,
            CURSOR (SELECT episode_number, title, description, rating
                    FROM episodes e
                    WHERE e.season_id = s.season_id)
        FROM seasons s
        WHERE series_id = id_serial;
    episoade ref_cursor;
    id_serial series.series_id%TYPE;
    numar_sez seasons.season_number%TYPE;
    inceput_sez seasons.starting_date%TYPE;
    sfarsit_sez seasons.ending_date%TYPE;
    TYPE ep IS RECORD (numar episodes.episode_number%TYPE,
                       titlu episodes.title%TYPE,
                       descriere episodes.description%TYPE,
                       rating episodes.rating%TYPE);
    episod ep;
    exista_sezoane BOOLEAN := FALSE;
    exista_episoade BOOLEAN;
BEGIN
    -- determinare id serial
    SELECT series_id INTO id_serial
    FROM series
    WHERE title = serial;
    
    OPEN sezoane(id_serial);
    LOOP
        FETCH sezoane INTO numar_sez, inceput_sez, sfarsit_sez, episoade;
        EXIT WHEN sezoane%NOTFOUND;
        exista_sezoane := TRUE;  
            
        -- afisare sezon
        DBMS_OUTPUT.PUT_LINE('------------------------------------------');
        DBMS_OUTPUT.PUT('SEZONUL ' || numar_sez || ': ' || inceput_sez || ' - ');
            
        IF sfarsit_sez IS NULL THEN
            -- sezonul se afla in derulare
            DBMS_OUTPUT.PUT_LINE('prezent');
        ELSE
            DBMS_OUTPUT.PUT_LINE(sfarsit_sez);
        END IF;
            
        -- afisare episoade
        exista_episoade := FALSE;
            
        LOOP
            FETCH episoade INTO episod;
            EXIT WHEN episoade%NOTFOUND;
                
            exista_episoade := TRUE;
                
            DBMS_OUTPUT.PUT_LINE(episod.numar || '. ' || episod.titlu || ' - ' || episod.rating);
            DBMS_OUTPUT.PUT_LINE('Synopsis: ' || episod.descriere);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
            
        IF NOT exista_episoade THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista episoade pentru acest sezon');
        END IF;
            
        DBMS_OUTPUT.PUT_LINE('------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
    CLOSE sezoane;
    
    IF NOT exista_sezoane THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista sezoane pentru acest serial');
    END IF;
EXCEPTION 
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20004, 'Nu exista serial cu numele dat');
    WHEN too_many_rows THEN
        RAISE_APPLICATION_ERROR(-20005, 'Exista mai multe seriale cu acest nume');
END;
/

-- merge
EXECUTE afisare_episoade('The 100');

-- merge
EXECUTE afisare_episoade('The Magicians');

INSERT INTO seasons
VALUES (13, 1, '16-DEC-15', '11-APR-16', 7);

-- merge
EXECUTE afisare_episoade('The Magicians');

ROLLBACK;

-- eroare: nu exista serialul
EXECUTE afisare_episoade('Riverdale');


-- Functie care sa utilizeze 3 tabele diferite
-- Sa se determine numarul de episoade in care joaca un anumit actor
-- intr-o anumita perioada de timp
CREATE OR REPLACE FUNCTION nr_episoade
    (prenume actors.first_name%TYPE := NULL,
     nume actors.last_name%TYPE := NULL,
     inceput DATE,
     sfarsit DATE)
RETURN NUMBER IS
    nr_ep NUMBER(3);
    id_actor actors.actor_id%TYPE;    
BEGIN
    IF inceput > sfarsit THEN
        RAISE_APPLICATION_ERROR(-20006, 'Data de inceput trebuie sa fie mai mica decat data de sfarsit');
        RETURN -1;
    END IF;
    
    IF prenume IS NULL AND nume IS NULL THEN
        RAISE_APPLICATION_ERROR(-20007, 'Nu poate sa fie si numele si prenumele NULL');
        RETURN -1;
    END IF;
    
    -- determinarea id-ului actorului dat
    -- (acest pas se face separat ca sa se poata arunca exceptie in cazul in care
    -- nu exista actorulul sau exista mai multi acotri cu acest nume)
    IF nume IS NOT NULL AND prenume IS NOT NULL THEN
        -- numele si prenumele nusunt NULL
        SELECT actor_id INTO id_actor
        FROM actors
        WHERE first_name = prenume 
          AND last_name = nume;
    ELSIF nume IS NULL AND prenume IS NOT NULL THEN
        -- prenumele nu este NULL
        SELECT actor_id INTO id_actor
        FROM actors
        WHERE first_name = prenume;
    ELSE
        -- numele nu este NULL
        SELECT actor_id INTO id_actor
        FROM actors
        WHERE last_name = nume;
    END IF;
              
      
    SELECT COUNT(*) INTO nr_ep
    FROM playing p JOIN characters ch ON (p.character_id = ch.character_id)
                   JOIN appearing_in ap ON (ch.character_id = ap.character_id)
                   JOIN episodes e ON (ap.episode_id = e.episode_id)
    WHERE p.actor_id = id_actor
      AND (p.starting_date <= sfarsit AND p.ending_date >= inceput)
      AND e.airing_date BETWEEN inceput AND sfarsit;
    
    RETURN nr_ep;
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20004, 'Nu exista actor cu numele dat');
        RETURN -1;
    WHEN too_many_rows THEN
        RAISE_APPLICATION_ERROR(-20005, 'Exista mai multi actori cu acest nume');
        RETURN -1;
END;
/

-- merge
SELECT nr_episoade('Jared', 'Padalecki', '13-MAY-10', '12-NOV-20') FROM dual;

-- merge
SELECT nr_episoade('Joseph', null, '13-MAY-14', '20-MAY-16') FROM dual;

-- merge
SELECT nr_episoade(null, 'Master', '23-OCT-10', '06-DEC-16') FROM dual;

-- eroare: exista mai multi actori ci acest nume
SELECT nr_episoade(null, 'Morgan', '18-MAY-14', '19-APR-16') FROM dual;

-- eroare: nu exista actor cu acest nume
SELECT nr_episoade('John', 'Doe', '13-MAY-14', '20-MAY-16') FROM dual;

-- eroare: numele si prenumele nu pot fi ambele null
SELECT nr_episoade(null, null, '13-APR-14', '25-Jan-15') FROM dual;

-- eoare: data de inceput este mai mare decta data de sfarsit
SELECT nr_episoade('Emily Bett', 'Rickards', '13-SEP-14', '20-AUG-14') FROM dual;


-- Procedura care sa utilizeze 5 tabele diferite
-- Sa se afiseze pentru fiecare serial numele serialului, producatorii 
-- si lista actorilor impreuna cu personajele pe care le interpreteaza
CREATE OR REPLACE PROCEDURE afisare_seriale AS
    TYPE pers IS RECORD (prenume producers.first_name%TYPE,
                         nume producers.last_name%TYPE);
    TYPE prod IS TABLE OF pers;                       
    v_producatori prod;
    CURSOR actori (id_serial NUMBER) IS
        SELECT a.actor_id, a.first_name, a.last_name
        FROM actors a JOIN playing p ON(a.actor_id = p.actor_id)
        WHERE series_id = id_serial;
    personaj pers;
    i INTEGER;
    exista_actori BOOLEAN;
BEGIN
    FOR serial IN (SELECT series_id, title
                   FROM series) 
               LOOP
        -- afisare serial
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('--- ' || UPPER(serial.title) || ' ---'); 
        
        -- afisare producatori
        DBMS_OUTPUT.PUT('--- Producatori: ');
        
        SELECT p.first_name, p.last_name BULK COLLECT INTO v_producatori
        FROM producers p JOIN produced_by ps ON (p.producer_id = ps.producer_id)
        WHERE series_id = serial.series_id;

        IF v_producatori.count() = 0 THEN
            -- nu exista producatori
            DBMS_OUTPUT.PUT('nu exista producatori');
        ELSE
            i := v_producatori.FIRST;
            WHILE i<= v_producatori.LAST LOOP
                DBMS_OUTPUT.PUT(v_producatori(i).prenume || ' ' || v_producatori(i).nume);
                IF i <> v_producatori.LAST THEN
                    DBMS_OUTPUT.PUT(', ');
                END IF;
                
                i := v_producatori.NEXT(i);
            END LOOP;
        END IF;
        
        DBMS_OUTPUT.PUT(' ---');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
        
        -- afisare actori
        exista_actori := FALSE;
        FOR actor in actori(serial.series_id) LOOP
            exista_actori := TRUE;
            DBMS_OUTPUT.PUT(actor.first_name || ' ' || actor.last_name || ' - ');
            
            -- afisare personajul jucat de actor
            SELECT c.first_name, c.last_name INTO personaj
            FROM characters c JOIN playing p USING(character_id)
            WHERE actor_id = actor.actor_id;
            
            DBMS_OUTPUT.PUT(personaj.prenume || ' ' || personaj.nume);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
        
        IF NOT exista_actori THEN
            -- nu exista actori
            DBMS_OUTPUT.PUT_LINE('Nu exista actori');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/

-- merge
EXECUTE afisare_seriale;