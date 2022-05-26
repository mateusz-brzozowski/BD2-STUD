set echo on
set linesize 300
set pagesize 500
spool BD2C007_DML.LIS

-- TEST SEKWENCJI

-- test sekwencji 'NR_KOLEJNY_SEQ' - dodanie nowej czesci konspektu

INSERT INTO czesci_konspektu VALUES ('CK', NULL, 'Część konspektu');

SELECT nr_kolejny
FROM czesci_konspektu
WHERE kod_czesci = 'CK';

ROLLBACK;

-- TEST KASKADY KASOWANIA

-- usunięcie przedmiotu, powinno spowodować usunięcie jego konepsktu

DELETE FROM przedmioty
WHERE kod_przedmiotu = 'FO';

SELECT *
FROM elementy_konspektu
WHERE kod_przedmiotu = 'FO';

ROLLBACK;

-- TESTY UNIQUE KEY

INSERT INTO kierunki VALUES ('TEST', 'Informatyka', NULL);

INSERT INTO kategorie_tematyczne VALUES ('TEST', 'Matematyka', NULL);

INSERT INTO czesci_konspektu VALUES ('TEST', 100, 'TEST');

INSERT INTO czesci_konspektu VALUES ('TEST', NULL, 'Opis');

INSERT INTO przedmioty VALUES ('TEST', 'Analiza matematyczna', 'INF', 'MAT', NULL);

-- TESTY PRIMARY KEY

INSERT INTO kierunki VALUES ('INF', 'TEST', NULL);

INSERT INTO kategorie_tematyczne VALUES ('MAT', 'TEST', NULL);

INSERT INTO przedmioty VALUES ('AM', 'TEST', 'INF', 'MAT', NULL);

INSERT INTO czesci_konspektu VALUES ('OP', NULL, 'TEST');

INSERT INTO elementy_konspektu VALUES ('AM', 'OP', 'TEST');

-- TESTY WYZWALACZY

-- test wyzwalacza 'FKNTM_ELEMENTY_KONSPEKTU' - zmiana nietransferowalnego klucza obcego

UPDATE elementy_konspektu
SET kod_przedmiotu = 'MAT'
WHERE kod_czesci = 'OP';

UPDATE elementy_konspektu
SET kod_czesci = 'OP'
WHERE kod_przedmiotu = 'AM';

spool off