-- INSERARE DATE
-- producers
INSERT INTO producers
VALUES (1, 'Eric', 'Kripke', '24-APR-1974');

INSERT INTO producers
VALUES (2, 'Stephanie', 'Savage', TO_DATE('1969', 'YYYY'));

INSERT INTO producers
VALUES (3, 'Josh', 'Schwartz', '06-AUG-1976');

INSERT INTO producers
VALUES (4, 'Julie', 'Plec', '26-MAY-1972');

INSERT INTO producers
VALUES (5, 'Greg', 'Berlanti', '24-MAY-1972');

INSERT INTO producers
VALUES (6, 'Marc', 'Guggenheim', '24-SEP-1970');

INSERT INTO producers
VALUES (7, 'Andrew', 'Kreisberg', '23-APR-1971');

INSERT INTO producers
VALUES (8, 'Jason', 'Rothenberg', null);

INSERT INTO producers
VALUES (9, 'Tom', 'Kapinos', TO_DATE('1969', 'YYYY'));

SELECT * FROM producers;
COMMIT;

-- series
INSERT INTO series
VALUES (1, 'Supernatural', 
    'Two brothers follow their father''s footsteps as hunters, fighting evil supernatural beings of many kinds, including monsters, demons and gods that roam the earth.', 
    8.4, TO_DATE('13-Sep-2005', 'DD MONTH YYYY'), TO_DATE('19-Nov-2020', 'DD MONTH YYYY'), genres('Drama', 'Fantasy', 'Horror'));
    
INSERT INTO series
VALUES (2, 'Gossip Girl', 
    'Privileged teens living on the Upper East Side of New York can hide no secret from the ruthless blogger who is always watching.', 
    7.4, TO_DATE('19-Sep-2007', 'DD MONTH YYYY'), TO_DATE('17-Dec-2012', 'DD MONTH YYYY'), genres('Drama', 'Romance'));
    
INSERT INTO series
VALUES (3, 'The Originals', 
    'A family of power-hungry thousand-year-old vampires look to take back the city that they built and dominate all those who have done them wrong.', 
    8.2, TO_DATE('3-Oct-2013', 'DD MONTH YYYY'), TO_DATE('1-Aug-2018', 'DD MONTH YYYY'), genres('Drama', 'Fantasy', 'Horror'));
    
INSERT INTO series
VALUES (4, 'Arrow', 
    'Spoiled billionaire playboy Oliver Queen is missing and presumed dead when his yacht is lost at sea. He returns five years later a changed man, determined to clean up the city as a hooded vigilante armed with a bow.', 
    7.5, TO_DATE('10-Oct-2012', 'DD MONTH YYYY'), TO_DATE('28-Jan-2020', 'DD MONTH YYYY'), genres('Action', 'Adventure', 'Crime'));
    
INSERT INTO series
VALUES (5, 'The 100', 
    'Set ninety-seven years after a nuclear war has destroyed civilization, when a spaceship housing humanity''s lone survivors sends one hundred juvenile delinquents back to Earth, in hopes of possibly re-populating the planet.', 
    7.6, TO_DATE('19-Mar-2014', 'DD MONTH YYYY'), TO_DATE('30-Sep-2020', 'DD MONTH YYYY'), genres('Drama', 'Mystery', 'Sci-Fi'));
    
INSERT INTO series
VALUES (6, 'Lucifer', 
    'Lucifer Morningstar has decided he''s had enough of being the dutiful servant in Hell and decides to spend some time on Earth to better understand humanity. He settles in Los Angeles - the City of Angels.', 
    8.2, TO_DATE('25-Jan-2016', 'DD MONTH YYYY'), NULL, genres('Crime', 'Drama', 'Fantasy'));
    
INSERT INTO series
VALUES (7, 'The Magicians', 
    'After being recruited to a secretive academy, a group of students discover that the magic they read about as children is very real-and more dangerous than they ever imagined.', 
    7.6, TO_DATE('26-Dec-2015', 'DD MONTH YYYY'), TO_DATE('1-Apr-2020', 'DD MONTH YYYY'), genres('Drama', 'Fantasy', 'Mystery'));
    
SELECT * FROM series;
COMMIT;

-- produced_by
INSERT INTO produced_by
VALUES (1, 1);

INSERT INTO produced_by
VALUES (2, 2);

INSERT INTO produced_by
VALUES (3, 2);

INSERT INTO produced_by
VALUES (4, 3);

INSERT INTO produced_by
VALUES (5, 4);

INSERT INTO produced_by
VALUES (6, 4);

INSERT INTO produced_by
VALUES (7, 4);

INSERT INTO produced_by
VALUES (8, 5);

INSERT INTO produced_by
VALUES (9, 6);

SELECT * FROM produced_by;
COMMIT;

-- seasons
INSERT INTO seasons
VALUES (1, 5, TO_DATE('10-Sep-2009', 'DD MONTH YYYY'), TO_DATE('13-May-2010', 'DD MONTH YYYY'), 1);

INSERT INTO seasons
VALUES (2, 15, TO_DATE('10-Oct-2019', 'DD MONTH YYYY'), TO_DATE('19-Nov-2020', 'DD MONTH YYYY'), 1);

INSERT INTO seasons
VALUES (3, 1, TO_DATE('19-Sep-2007', 'DD MONTH YYYY'), TO_DATE('19-May-2008', 'DD MONTH YYYY'), 2);

INSERT INTO seasons
VALUES (4, 6, TO_DATE('8-Oct-2011', 'DD MONTH YYYY'), TO_DATE('17-Dec-2012', 'DD MONTH YYYY'), 2);

INSERT INTO seasons
VALUES (5, 1, TO_DATE('3-Oct-2013', 'DD MONTH YYYY'), TO_DATE('13-May-2014', 'DD MONTH YYYY'), 3);

INSERT INTO seasons
VALUES (6, 3, TO_DATE('8-Oct-2015', 'DD MONTH YYYY'), TO_DATE('20-May-2016', 'DD MONTH YYYY'), 3);

INSERT INTO seasons
VALUES (7, 2, TO_DATE('9-Oct-2013', 'DD MONTH YYYY'), TO_DATE('14-May-2014', 'DD MONTH YYYY'), 4);

INSERT INTO seasons
VALUES (8, 3, TO_DATE('8-Oct-2014', 'DD MONTH YYYY'), TO_DATE('13-May-2015', 'DD MONTH YYYY'), 4);

INSERT INTO seasons
VALUES (9, 1, TO_DATE('19-Mar-2014', 'DD MONTH YYYY'), TO_DATE('11-Jun-2014', 'DD MONTH YYYY'), 5);

INSERT INTO seasons
VALUES (10, 5, TO_DATE('24-Apr-2018', 'DD MONTH YYYY'), TO_DATE('7-Aug-2018', 'DD MONTH YYYY'), 5);

INSERT INTO seasons
VALUES (11, 1, TO_DATE('25-Jan-2016', 'DD MONTH YYYY'), TO_DATE('25-Apr-2016', 'DD MONTH YYYY'), 6);

INSERT INTO seasons
VALUES (12, 4, TO_DATE('8-May-2019', 'DD MONTH YYYY'), TO_DATE('8-May-2019', 'DD MONTH YYYY'), 6);

SELECT * FROM seasons;
COMMIT;

-- episodes
INSERT INTO episodes
VALUES (1, 22, 'Swan Song', 'With the Apocalypse looming, Sam and Dean realize they are out of options and make heart-breaking decisions that will change their lives forever.',
    43, TO_DATE('13-May-2010', 'DD MONTH YYYY'), 9.7, 1);
    
INSERT INTO episodes
VALUES (2, 8, 'Changing Channels', 'Sam and Dean catch up with the Trickster, who sends them through a dizzying montage of TV show parodies, inviting them to play along with their "roles" or be stuck in "TV Land" forever. But once Castiel shows up, the boys get an idea as to what the Trickster might be hiding and eventually come up with a surprising answer.',
    43, TO_DATE('5-Nov-2009', 'DD MONTH YYYY'), 9.7, 1);
    
INSERT INTO episodes
VALUES (3, 19, 'Inherit the Earth', 'Everything is on the line as the battle against God continues; a familiar face returns to join the fight.',
    43, TO_DATE('12-Nov-2020', 'DD MONTH YYYY'), 8.2, 2);
    
INSERT INTO episodes
VALUES (4, 10, 'New York, I Love You XOXO', 'In a fashionable farewell to remember, our favorite Upper East Siders join forces for one last soiree; The identity of Gossip Girl is finally revealed.',
    41, TO_DATE('17-Dec-2012', 'DD MONTH YYYY'), 9.1, 4);
    
INSERT INTO episodes
VALUES (5, 7, 'Victor/Victrola', 'Serena and Dan finally acknowledge they are crazy about each other; Jenny discovers a secret about her parents; Blair is once again devastated by Nate''s actions.',
    42, TO_DATE('7-Nov-2007', 'DD MONTH YYYY'), 8.2, 3);
    
INSERT INTO episodes
VALUES (6, 22, 'From a Cradle to a Grave', 'As the baby''s due date draws near, Klaus and Elijah embark on a search for Hayley, while Hayley determines to do whatever it takes to keep her unborn baby safe and away from the witches. Francesca takes a meeting with Oliver and Jackson to determine the future of the werewolves in New Orleans. In the aftermath of a surprising attack on Marcel and his vampires at the compound, Davina and Cami join resources to take down Klaus. Finally, in a desperate move to protect those most important to him, Klaus makes a heartbreaking decision.',
    42, TO_DATE('13-May-2014', 'DD MONTH YYYY'), 9.6, 5);

INSERT INTO episodes
VALUES (7, 22, 'The Bloody Crown', 'After months of thwarting off dangerous threats and deadly attacks, the Mikaelson siblings finally come face to face with the one person that could lead to their ultimate demise. With the stakes higher than ever and the compound overrun by an army of his oldest sworn enemies, Klaus is put on trial for centuries of atrocities he''s committed. Meanwhile, Marcel, who has been spiraling out of control following an act of betrayal by those closest to him, is stunned by the unexpected arrival of someone from his past. Finally, Elijah, Freya and Kol frantically search for a way to save their family before it''s too late. Hayley also appears.',
    42, TO_DATE('20-May-2016', 'DD MONTH YYYY'), 9.6, 6);
    
INSERT INTO episodes
VALUES (8, 14, 'A Streetcar Named Desire', 'The unexpected arrival of Stefan Salvatore may be the key to helping Freya rescue Klaus and Elijah from a magical trap.',
    42, TO_DATE('26-Feb-2016', 'DD MONTH YYYY'), 9.4, 6);
    
INSERT INTO episodes
VALUES (9, 9, 'The Climb', 'The League of Assassins give Oliver 48 hours to find Sara''s killer, or Starling City citizens will die. Oliver then has an epic confrontation with Ra''s al Ghul.',
    42, TO_DATE('10-Dec-2014', 'DD MONTH YYYY'), 9.6, 8);
    
INSERT INTO episodes
VALUES (10, 23, 'Unthinkable', 'As Oliver''s face off with Slade escalates, his resolve to the no-kill rule is tested. Especially as Slade targets the woman Oliver loves.',
    44, TO_DATE('14-May-2014', 'DD MONTH YYYY'), 9.5, 7);

INSERT INTO episodes
VALUES (11, 18, 'Deathstroke', 'After taking a ride home from Slade, Thea becomes his prisoner. Can Oliver and his friends save her? Also, someone close to Oliver is working for Slade, since his return from the Island after Tommy''s death.',
    42, TO_DATE('2-Apr-2014', 'DD MONTH YYYY'), 9.3, 7);
 
INSERT INTO episodes
VALUES (12, 13, 'Damocles: Part Two', 'Clarke and her friends must risk everything to fight one last battle for survival, only to glimpse an even darker threat to the last living valley on earth.',
    42, TO_DATE('7-Aug-2018', 'DD MONTH YYYY'), 9.6, 10);
    
INSERT INTO episodes
VALUES (13, 12, 'Damocles: Part One', 'In part one of the fifth season finale, Octavia leads her people into war. While behind enemy lines, our heroes must overcome their differences to save Wonkru from extinction.',
    42, TO_DATE('31-Jul-2018', 'DD MONTH YYYY'), 9.0, 10);

INSERT INTO episodes
VALUES (14, 12, 'We Are Grounders: Part 2', 'As the remaining members of the 100 face off against the Grounders, Jaha makes a noble sacrifice to ensure the Ark makes it to Earth.',
    42, TO_DATE('11-Jul-2018', 'DD MONTH YYYY'), 8.9, 9); 
   
INSERT INTO episodes
VALUES (15, 11, 'We Are Grounders: Part 1', 'Clarke and Finn come face to face with a new enemy after Lincoln rescues them from Anya, while Bellamy, Raven, Octavia and Jasper deal with a vengeful Murphy. On the Ark, Jaha makes a plan to try and get to Earth.',
    43, TO_DATE('4-Jul-2018', 'DD MONTH YYYY'), 8.4, 9);

INSERT INTO episodes
VALUES (16, 10, 'Who''s da New King of Hell?', 'With murderous demons on the loose in Los Angeles, it''s up to Lucifer to rein in the chaos and protect the ones he most cares about.',
    55, TO_DATE('8-May-2019', 'DD MONTH YYYY'), 9.7, 12);
    
INSERT INTO episodes
VALUES (17, 7, 'Devil Is as Devil Does', 'Eve takes a more active role in her main man''s professional life. Meanwhile, Lucifer gets back to basics and Amenadiel fights for his family.',
    47, TO_DATE('8-May-2019', 'DD MONTH YYYY'), 9.3, 12);
    
INSERT INTO episodes
VALUES (18, 13, 'Take Me Back to Hell', 'When Lucifer is framed for murder, he and Chloe must work together to clear his name and prove the identity of the true killer.',
    43, TO_DATE('25-Apr-2016', 'DD MONTH YYYY'), 9.2, 11);
    
SELECT * FROM episodes;
COMMIT;

-- characters
INSERT INTO characters
VALUES (1, 'Sam', 'Winchester', 1);

INSERT INTO characters
VALUES (2, 'Dean', 'Winchester', 1);

INSERT INTO characters
VALUES (3, 'Castiel', null, 1);

INSERT INTO characters
VALUES (4, 'Crowley', null, 1);

INSERT INTO characters
VALUES (5, 'Jack', null, 1);

INSERT INTO characters
VALUES (6, 'God', null, 1);

INSERT INTO characters
VALUES (7, 'Serena', 'van der Woodsen' , 2);

INSERT INTO characters
VALUES (8, 'Blair', 'Waldorf', 2);

INSERT INTO characters
VALUES (9, 'Dan', 'Humphrey', 2);

INSERT INTO characters
VALUES (10, 'Chuck', 'Bass', 2);

INSERT INTO characters
VALUES (11, 'Nate', 'Archibald', 2);

INSERT INTO characters
VALUES (12, 'Klaus', 'Mikaelson', 3);

INSERT INTO characters
VALUES (13, 'Elijah', 'Mikaelson', 3);

INSERT INTO characters
VALUES (14, 'Rebekah', 'Mikaelson', 3);

INSERT INTO characters
VALUES (15, 'Freya', 'Mikaelson', 3);

INSERT INTO characters
VALUES (16, 'Kol', 'Mikaelson', 3);

INSERT INTO characters
VALUES (17, 'Hope', 'Mikaelson', 3);

INSERT INTO characters
VALUES (18, 'Hayley', 'Marshall', 3);

INSERT INTO characters
VALUES (19, 'Marcel', 'Gerard', 3);

INSERT INTO characters
VALUES (20, 'Oliver', 'Queen', 4);

INSERT INTO characters
VALUES (21, 'Thea', 'Queen', 4);

INSERT INTO characters
VALUES (22, 'Felicity', 'Smoak', 4);

INSERT INTO characters
VALUES (23, 'John', 'Diggle', 4);

INSERT INTO characters
VALUES (24, 'Laurel', 'Lance', 4);

INSERT INTO characters
VALUES (25, 'Slade', 'Wilson', 4);

INSERT INTO characters
VALUES (26, 'Clark', 'Griffin', 5);

INSERT INTO characters
VALUES (27, 'Octavia', 'Blake', 5);

INSERT INTO characters
VALUES (28, 'Bellamy', 'Blake', 5);

INSERT INTO characters
VALUES (29, 'Raven', 'Reyes', 5);

INSERT INTO characters
VALUES (30, 'John', 'Murphy', 5);

INSERT INTO characters
VALUES (31, 'Monty', 'Green', 5);

INSERT INTO characters
VALUES (32, 'Lucifer', 'Morningstar', 6);

INSERT INTO characters
VALUES (33, 'Chloe', 'Decker', 6);

INSERT INTO characters
VALUES (34, 'Amenadiel', null, 6);

INSERT INTO characters
VALUES (35, 'Mazikeen',null, 6);

INSERT INTO characters
VALUES (36, 'Linda', 'Martin', 6);

SELECT * FROM characters;
COMMIT;

-- appearing_in
INSERT INTO appearing_in
VALUES (1, 1);

INSERT INTO appearing_in
VALUES (1, 2);

INSERT INTO appearing_in
VALUES (1, 3);

INSERT INTO appearing_in
VALUES (2, 1);

INSERT INTO appearing_in
VALUES (2, 2);

INSERT INTO appearing_in
VALUES (2, 3);

INSERT INTO appearing_in
VALUES (3, 1);

INSERT INTO appearing_in
VALUES (3, 2);

INSERT INTO appearing_in
VALUES (3, 3);

INSERT INTO appearing_in
VALUES (3, 5);

INSERT INTO appearing_in
VALUES (3, 6);

INSERT INTO appearing_in
VALUES (4, 7);

INSERT INTO appearing_in
VALUES (4, 8);

INSERT INTO appearing_in
VALUES (4, 9);

INSERT INTO appearing_in
VALUES (4, 10);

INSERT INTO appearing_in
VALUES (4, 11);

INSERT INTO appearing_in
VALUES (5, 7);

INSERT INTO appearing_in
VALUES (5, 8);

INSERT INTO appearing_in
VALUES (5, 9);

INSERT INTO appearing_in
VALUES (5, 10);

INSERT INTO appearing_in
VALUES (5, 11);

INSERT INTO appearing_in
VALUES (6, 12);

INSERT INTO appearing_in
VALUES (6, 13);

INSERT INTO appearing_in
VALUES (6, 14);

INSERT INTO appearing_in
VALUES (6, 18);

INSERT INTO appearing_in
VALUES (6, 19);

INSERT INTO appearing_in
VALUES (7, 12);

INSERT INTO appearing_in
VALUES (7, 13);

INSERT INTO appearing_in
VALUES (7, 14);

INSERT INTO appearing_in
VALUES (7, 15);

INSERT INTO appearing_in
VALUES (7, 16);

INSERT INTO appearing_in
VALUES (7, 18);

INSERT INTO appearing_in
VALUES (7, 19);

INSERT INTO appearing_in
VALUES (8, 12);

INSERT INTO appearing_in
VALUES (8, 13);

INSERT INTO appearing_in
VALUES (8, 15);

INSERT INTO appearing_in
VALUES (8, 16);

INSERT INTO appearing_in
VALUES (8, 18);

INSERT INTO appearing_in
VALUES (8, 19);

INSERT INTO appearing_in
VALUES (9, 20);

INSERT INTO appearing_in
VALUES (9, 21);

INSERT INTO appearing_in
VALUES (9, 22);

INSERT INTO appearing_in
VALUES (9, 23);

INSERT INTO appearing_in
VALUES (9, 24);

INSERT INTO appearing_in
VALUES (10, 20);

INSERT INTO appearing_in
VALUES (10, 21);

INSERT INTO appearing_in
VALUES (10, 22);

INSERT INTO appearing_in
VALUES (10, 23);

INSERT INTO appearing_in
VALUES (10, 24);

INSERT INTO appearing_in
VALUES (10, 25);

INSERT INTO appearing_in
VALUES (11, 20);

INSERT INTO appearing_in
VALUES (11, 21);

INSERT INTO appearing_in
VALUES (11, 22);

INSERT INTO appearing_in
VALUES (11, 23);

INSERT INTO appearing_in
VALUES (11, 24);

INSERT INTO appearing_in
VALUES (11, 25);

INSERT INTO appearing_in
VALUES (12, 26);

INSERT INTO appearing_in
VALUES (12, 27);

INSERT INTO appearing_in
VALUES (12, 28);

INSERT INTO appearing_in
VALUES (12, 29);

INSERT INTO appearing_in
VALUES (12, 30);

INSERT INTO appearing_in
VALUES (12, 31);

INSERT INTO appearing_in
VALUES (13, 26);

INSERT INTO appearing_in
VALUES (13, 27);

INSERT INTO appearing_in
VALUES (13, 28);

INSERT INTO appearing_in
VALUES (13, 29);

INSERT INTO appearing_in
VALUES (13, 30);

INSERT INTO appearing_in
VALUES (13, 31);

INSERT INTO appearing_in
VALUES (14, 26);

INSERT INTO appearing_in
VALUES (14, 27);

INSERT INTO appearing_in
VALUES (14, 28);

INSERT INTO appearing_in
VALUES (14, 29);

INSERT INTO appearing_in
VALUES (14, 30);

INSERT INTO appearing_in
VALUES (14, 31);

INSERT INTO appearing_in
VALUES (15, 26);

INSERT INTO appearing_in
VALUES (15, 27);

INSERT INTO appearing_in
VALUES (15, 28);

INSERT INTO appearing_in
VALUES (15, 29);

INSERT INTO appearing_in
VALUES (15, 30);

INSERT INTO appearing_in
VALUES (15, 31);

INSERT INTO appearing_in
VALUES (16, 32);

INSERT INTO appearing_in
VALUES (16, 33);

INSERT INTO appearing_in
VALUES (16, 34);

INSERT INTO appearing_in
VALUES (16, 35);

INSERT INTO appearing_in
VALUES (16, 36);

INSERT INTO appearing_in
VALUES (17, 32);

INSERT INTO appearing_in
VALUES (17, 33);

INSERT INTO appearing_in
VALUES (17, 34);

INSERT INTO appearing_in
VALUES (17, 35);

INSERT INTO appearing_in
VALUES (17, 36);

INSERT INTO appearing_in
VALUES (18, 32);

INSERT INTO appearing_in
VALUES (18, 33);

INSERT INTO appearing_in
VALUES (18, 34);

INSERT INTO appearing_in
VALUES (18, 35);

INSERT INTO appearing_in
VALUES (18, 36);

SELECT * FROM appearing_in;
COMMIT;

-- actors
INSERT INTO actors
VALUES (1, 'Jared', 'Padalecki', '19-JUL-1982');

INSERT INTO actors
VALUES (2, 'Jensen', 'Ackles', '01-MAR-1978');

INSERT INTO actors
VALUES (3, 'Misha', 'Collins', '20-AUG-1974');

INSERT INTO actors
VALUES (4, 'Mark', 'Sheppard', '30-MAY-1964');

INSERT INTO actors
VALUES (5, 'Alexander', 'Calvert', '15-JUL-1990');

INSERT INTO actors
VALUES (6, 'Rob', 'Benedict', '21-SEP-1970');

INSERT INTO actors
VALUES (7, 'Blake', 'Lively', '25-AUG-1987');

INSERT INTO actors
VALUES (8, 'Leighton', 'Master', '09-APR-1986');

INSERT INTO actors
VALUES (9, 'Penn', 'Badgley', '01-NOV-1986');

INSERT INTO actors
VALUES (10, 'Ed', 'Westwick', '27-JUN-1987');

INSERT INTO actors
VALUES (11, 'Chace', 'Crawford', '18-JUL-1985');

INSERT INTO actors
VALUES (12, 'Joseph', 'Morgan', '16-MAY-1981');

INSERT INTO actors
VALUES (13, 'Daniel', 'Gilles', '14-MAR-1976');

INSERT INTO actors
VALUES (14, 'Claire', 'Holt', '11-JUN-1988');

INSERT INTO actors
VALUES (15, 'Riley', 'Voelkel', '26-APR-1990');

INSERT INTO actors
VALUES (16, 'Nathaniel', 'Buzolic', '04-AUG-1983');

INSERT INTO actors
VALUES (17, 'Danielle Rose', 'Russell', '31-OCT-1999');

INSERT INTO actors
VALUES (18, 'Phoebe', 'Tonkin', '12-JUL-1989');

INSERT INTO actors
VALUES (19, 'Charles Michael', 'Davis', '01-DEC-1984');

INSERT INTO actors
VALUES (20, 'Stephen', 'Amell', '08-MAY-1981');

INSERT INTO actors
VALUES (21, 'Willa', 'Holland', '18-JUN-1991');

INSERT INTO actors
VALUES (22, 'Emily Bett', 'Rickards', '24-JUL-1991');

INSERT INTO actors
VALUES (23, 'David', 'Ramsey', '17-NOV-1971');

INSERT INTO actors
VALUES (24, 'Katie', 'Cassidy', '25-NOV-1986');

INSERT INTO actors
VALUES (25, 'Manu', 'Bennett', '10-OCT-1969');

INSERT INTO actors
VALUES (26, 'Eliza', 'Taylor', '24-OCT-1989');

INSERT INTO actors
VALUES (27, 'Marie', 'Avgeropoulos', '17-JUN-1986');

INSERT INTO actors
VALUES (28, 'Bob', 'Morley', '20-DEC-1984');

INSERT INTO actors
VALUES (29, 'Lindsey', 'Morgan', '27-FEB-1990');

INSERT INTO actors
VALUES (30, 'Richard', 'Harmon', '18-AUG-1991');

INSERT INTO actors
VALUES (31, 'Cristopher', 'Larkin', '02-OCT-1987');

INSERT INTO actors
VALUES (32, 'Tom', 'Ellis', '17-NOV-1978');

INSERT INTO actors
VALUES (33, 'Lauren', 'German', '29-NOV-1978');

INSERT INTO actors
VALUES (34, 'David Bryan', 'Woodside', '25-JUL-1969');

INSERT INTO actors
VALUES (35, 'Lesley-Ann', 'Brandt', '02-DEC-1981');

INSERT INTO actors
VALUES (36, 'Rachel', 'Harris', '12-JAN-1968');

SELECT * FROM actors;
COMMIT;

-- playing
INSERT INTO playing
VALUES (1, 1, 1, TO_DATE('2005', 'YYYY'), TO_DATE('2020', 'YYYY'), 327);

INSERT INTO playing
VALUES (1, 2, 2, TO_DATE('2005', 'YYYY'), TO_DATE('2020', 'YYYY'), 327);

INSERT INTO playing
VALUES (1, 3, 3, TO_DATE('2008', 'YYYY'), TO_DATE('2020', 'YYYY'), 148);

INSERT INTO playing
VALUES (1, 4, 4, TO_DATE('2009', 'YYYY'), TO_DATE('2017', 'YYYY'), 72);

INSERT INTO playing
VALUES (1, 5, 5, TO_DATE('2017', 'YYYY'), TO_DATE('2020', 'YYYY'), 39);

INSERT INTO playing
VALUES (1, 6, 6, TO_DATE('2009', 'YYYY'), TO_DATE('2020', 'YYYY'), 9);

INSERT INTO playing
VALUES (2, 7, 7, TO_DATE('2007', 'YYYY'), TO_DATE('2012', 'YYYY'), 121);

INSERT INTO playing
VALUES (2, 8, 8, TO_DATE('2007', 'YYYY'), TO_DATE('2012', 'YYYY'), 121);

INSERT INTO playing
VALUES (2, 9, 9, TO_DATE('2007', 'YYYY'), TO_DATE('2012', 'YYYY'), 121);

INSERT INTO playing
VALUES (2, 10, 10, TO_DATE('2007', 'YYYY'), TO_DATE('2012', 'YYYY'), 121);

INSERT INTO playing
VALUES (2, 11, 11, TO_DATE('2007', 'YYYY'), TO_DATE('2012', 'YYYY'), 121);

INSERT INTO playing
VALUES (3, 12, 12, TO_DATE('2013', 'YYYY'), TO_DATE('2018', 'YYYY'), 92);

INSERT INTO playing
VALUES (3, 13, 13, TO_DATE('2013', 'YYYY'), TO_DATE('2018', 'YYYY'), 92);

INSERT INTO playing
VALUES (3, 14, 14, TO_DATE('2013', 'YYYY'), TO_DATE('2018', 'YYYY'), 40);

INSERT INTO playing
VALUES (3, 15, 15, TO_DATE('2014', 'YYYY'), TO_DATE('2018', 'YYYY'), 60);

INSERT INTO playing
VALUES (3, 16, 16, TO_DATE('2013', 'YYYY'), TO_DATE('2018', 'YYYY'), 24);

INSERT INTO playing
VALUES (3, 17, 17, TO_DATE('2018', 'YYYY'), TO_DATE('2018', 'YYYY'), 13);

INSERT INTO playing
VALUES (3, 18, 18, TO_DATE('2013', 'YYYY'), TO_DATE('2018', 'YYYY'), 86);

INSERT INTO playing
VALUES (3, 19, 19, TO_DATE('2013', 'YYYY'), TO_DATE('2018', 'YYYY'), 92);

INSERT INTO playing
VALUES (4, 20, 20, TO_DATE('2012', 'YYYY'), TO_DATE('2020', 'YYYY'), 170);

INSERT INTO playing
VALUES (4, 21, 21, TO_DATE('2012', 'YYYY'), TO_DATE('2020', 'YYYY'), 134);

INSERT INTO playing
VALUES (4, 22, 22, TO_DATE('2012', 'YYYY'), TO_DATE('2020', 'YYYY'), 157);

INSERT INTO playing
VALUES (4, 23, 23, TO_DATE('2012', 'YYYY'), TO_DATE('2020', 'YYYY'), 170);

INSERT INTO playing
VALUES (4, 24, 24, TO_DATE('2012', 'YYYY'), TO_DATE('2020', 'YYYY'), 153);

INSERT INTO playing
VALUES (4, 25, 25, TO_DATE('2013', 'YYYY'), TO_DATE('2017', 'YYYY'), 40);

INSERT INTO playing
VALUES (5, 26, 26, TO_DATE('2014', 'YYYY'), TO_DATE('2020', 'YYYY'), 100);

INSERT INTO playing
VALUES (5, 27, 27, TO_DATE('2014', 'YYYY'), TO_DATE('2020', 'YYYY'), 100);

INSERT INTO playing
VALUES (5, 28, 28, TO_DATE('2014', 'YYYY'), TO_DATE('2020', 'YYYY'), 97);

INSERT INTO playing
VALUES (5, 29, 29, TO_DATE('2014', 'YYYY'), TO_DATE('2020', 'YYYY'), 98);

INSERT INTO playing
VALUES (5, 30, 30, TO_DATE('2014', 'YYYY'), TO_DATE('2020', 'YYYY'), 90);

INSERT INTO playing
VALUES (5, 31, 31, TO_DATE('2014', 'YYYY'), TO_DATE('2019', 'YYYY'), 73);

INSERT INTO playing
VALUES (6, 32, 32, TO_DATE('2016', 'YYYY'), null, 78);

INSERT INTO playing
VALUES (6, 33, 33, TO_DATE('2016', 'YYYY'), null, 78);

INSERT INTO playing
VALUES (6, 34, 34, TO_DATE('2016', 'YYYY'), null, 77);

INSERT INTO playing
VALUES (6, 35, 35, TO_DATE('2016', 'YYYY'), null, 77);

INSERT INTO playing
VALUES (6, 36, 36, TO_DATE('2016', 'YYYY'), null, 77);

SELECT * FROM playing;
COMMIT;