set echo on
set linesize 300
set pagesize 500
spool BD2C007_TEST.LIS

-- Przedmioty dostępne na kierunku 'Informatyka'

SELECT p.nazwa
FROM przedmioty p
JOIN kierunki k USING(kod_kierunku)
WHERE k.nazwa = 'Informatyka';

-- Konspekt dla przedmiotu 'Fizyka ogólna' w ustalonej kolejności

SELECT ck.tytul, ek.tresc
FROM elementy_konspektu ek
JOIN przedmioty p USING(kod_przedmiotu)
JOIN czesci_konspektu ck USING(kod_czesci)
WHERE p.nazwa = 'Fizyka ogólna'
ORDER BY ck.nr_kolejny ASC;

-- Lista dostępnych części konspektu, jakie możemy wykorzystać piszac konspekt

SELECT ck.tytul
FROM czesci_konspektu ck;

-- Dostępne kierunki

SELECT k.nazwa
FROM kierunki k;

-- Literatura wykorzystywana na kierunku 'Informatyka'

SELECT ek.tresc
FROM elementy_konspektu ek
JOIN czesci_konspektu ck USING(kod_czesci)
JOIN przedmioty p USING(kod_przedmiotu)
JOIN kierunki k ON(p.kod_kierunku = k.kod_kierunku)
WHERE ck.tytul = 'Literatura' AND k.nazwa = 'Informatyka';

-- Liczba przedmiotów w każdej kategorii tematycznej

SELECT kt.nazwa, COUNT(*)
FROM przedmioty p
JOIN kategorie_tematyczne kt USING(kod_kategorii)
GROUP BY kod_kategorii, kt.nazwa;

-- Liczba przedmiotów na kierunkach

SELECT k.nazwa, COUNT(*)
FROM przedmioty p
JOIN kierunki k USING(kod_kierunku)
GROUP BY kod_kierunku, k.nazwa;

-- Przedmioty na kierunku 'Informatyka' podzielone na kierunki tematyczne

SELECT kt.nazwa, p.nazwa
FROM przedmioty p
JOIN kategorie_tematyczne kt USING(kod_kategorii)
JOIN kierunki k USING(kod_kierunku)
WHERE k.nazwa = 'Informatyka';

spool off