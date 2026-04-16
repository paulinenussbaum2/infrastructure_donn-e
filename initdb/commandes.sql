INSERT INTO type_materiel (libelle)
SELECT DISTINCT (
    CASE 
    WHEN LOWER (TRIM(type_materiel)) LIKE '%banc%' then 'banc'
    WHEN LOWER (TRIM(type_materiel)) LIKE '%lampadaire%' then 'lampadaire'
    WHEN LOWER (TRIM(type_materiel)) LIKE '%corbeille%' then 'poubelle'
    WHEN LOWER (TRIM(type_materiel)) LIKE '%poubelle%' then 'poubelle'
    WHEN LOWER (TRIM(type_materiel)) LIKE '%fontaine%' then 'fontaine'
    WHEN LOWER (TRIM(type_materiel)) LIKE '%borne%' then 'borne recharge'
    WHEN LOWER (TRIM(type_materiel)) LIKE '%panneau%' then 'panneau'
    ELSE NULL
    END
)
FROM staging.inventaire_mobilier
WHERE type_materiel IS NOT NULL;


INSERT INTO type_materiau (libelle)
SELECT *
from (
SELECT DISTINCT 
CASE 
WHEN LOWER (TRIM(type_materiau)) LIKE '%bois%' then 'bois'
WHEN LOWER (TRIM(type_materiau)) LIKE '%métal%' then 'métal'
WHEN LOWER (TRIM(type_materiau)) LIKE '%metal%' then 'métal'
WHEN LOWER (TRIM(type_materiau)) LIKE '%sodium%' then 'sodium'
WHEN LOWER (TRIM(type_materiau)) LIKE '%LED%' then 'LED'
WHEN LOWER (TRIM(type_materiau)) LIKE '%pierre%' then 'pierre'
WHEN LOWER (TRIM(type_materiau)) LIKE '%béton%' then 'béton'
END as type_cleaned
FROM staging.inventaire_mobilier
)
WHERE type_cleaned IS NOT NULL;



INSERT INTO etat (libelle)
SELECT DISTINCT 
    CASE 
    WHEN LOWER (TRIM(etat)) LIKE '%usé%' then 'usé'
    WHEN LOWER (TRIM(etat)) LIKE '%bon%' then 'bon'
    WHEN LOWER (TRIM(etat)) LIKE '%à remplacer%' then 'à remplacer'
    ELSE NULL
    END
FROM staging.inventaire_mobilier
WHERE etat IS NOT NULL;


INSERT INTO statut (libelle)
SELECT DISTINCT
    CASE 
    WHEN LOWER (TRIM(statut)) LIKE '%en attente%' then 'en cours'
    WHEN LOWER (TRIM(statut)) LIKE '%en cours%' then 'en cours'
    WHEN LOWER (TRIM(statut)) LIKE '%fait%' then 'fait'
    ELSE NULL
    END
FROM staging.signalements
WHERE statut IS NOT NULL;


INSERT INTO type_intervention (libelle)
SELECT DISTINCT 
CASE 
WHEN LOWER (TRIM(type_intervention)) LIKE '%peinture%' then 'peinture'
WHEN LOWER (TRIM(type_intervention)) LIKE '%réparation%' then 'réparation'
WHEN LOWER (TRIM(type_intervention)) LIKE '%remise en service%' then 'réparation'
WHEN LOWER (TRIM(type_intervention)) LIKE '%remplacement%' then 'remplacement'
WHEN LOWER (TRIM(type_intervention)) LIKE '%réparation électrique%' then 'réparation'
WHEN LOWER (TRIM(type_intervention)) LIKE '%réparation fuite%' then 'réparation'
WHEN LOWER (TRIM(type_intervention)) LIKE '%réparation vitre%' then 'réparation'
WHEN LOWER (TRIM(type_intervention)) LIKE '%nettoyage%' then 'nettoyage'
WHEN LOWER (TRIM(type_intervention)) LIKE '%nettoyage tags%' then 'nettoyage'
WHEN LOWER (TRIM(type_intervention)) LIKE '%hivernage%' then 'hivernage'
WHEN LOWER (TRIM(type_intervention)) LIKE '%redressage mât%' then 'réparation'
WHEN LOWER (TRIM(type_intervention)) LIKE '%détartrage%' then 'détartrage'
WHEN LOWER (TRIM(type_intervention)) LIKE '%mise à jour logiciel%' then 'mise à jour logiciel'
ELSE NULL
    END
FROM staging.interventions
WHERE type_intervention IS NOT NULL;



INSERT INTO inventaire_mobilier(numero,lieu,latitude,longitude,date_installation,remarques,id_etat,id_type_materiau,id_type_materiel)
SELECT 
CASE
    WHEN numero LIKE 'B-%'   THEN CAST(REPLACE(numero, 'B-', '') AS INTEGER)
    WHEN numero LIKE 'B_%'   THEN CAST(REPLACE(numero, 'B_', '') AS INTEGER)
    WHEN numero LIKE 'L-%'   THEN CAST(REPLACE(numero, 'L-', '') AS INTEGER)
    WHEN numero LIKE 'EV_%'  THEN CAST(REPLACE(numero, 'EV_', '') AS INTEGER)
    WHEN numero LIKE 'P-%'   THEN CAST(REPLACE(numero, 'P-', '') AS INTEGER)
    WHEN numero LIKE 'L_%'   THEN CAST(REPLACE(numero, 'L_', '') AS INTEGER)
    WHEN numero LIKE 'P_%'   THEN CAST(REPLACE(numero, 'P_', '') AS INTEGER)
    WHEN numero LIKE 'F-%'   THEN CAST(REPLACE(numero, 'F-', '') AS INTEGER)
    WHEN numero LIKE 'PA-%'   THEN CAST(REPLACE(numero, 'PA-', '') AS INTEGER)
    ELSE CAST(numero AS INTEGER)
    --ELSE NULL
END, lieu, REPLACE(latitude, ',', '.')::NUMERIC(9,6),REPLACE(longitude, ',', '.')::NUMERIC(9,6),
    CASE
        WHEN date_installation LIKE '%.%.%' THEN TO_DATE(date_installation, 'DD.MM.YYYY')
        WHEN date_installation LIKE '____-__-__' THEN TO_DATE(date_installation, 'YYYY-MM-DD')
        WHEN date_installation = '2011' THEN CAST('2011-01-01' AS DATE)
        WHEN date_installation = '2012' THEN CAST('2012-01-01' AS DATE)
        WHEN date_installation = '2013' THEN CAST('2013-01-01' AS DATE)
        WHEN date_installation = '2014' THEN CAST('2014-01-01' AS DATE)
        WHEN date_installation = '2015' THEN CAST('2015-01-01' AS DATE)
        WHEN date_installation = '2016' THEN CAST('2016-01-01' AS DATE)
        WHEN date_installation = '2018' THEN CAST('2018-01-01' AS DATE)
        WHEN date_installation = '2019' THEN CAST('2019-01-01' AS DATE)
        WHEN date_installation = '2020' THEN CAST('2020-01-01' AS DATE)
        WHEN date_installation = '2021' THEN CAST('2021-01-01' AS DATE)
        WHEN date_installation = '2022' THEN CAST('2022-01-01' AS DATE)
        WHEN date_installation = '2023' THEN CAST('2023-01-01' AS DATE)
        WHEN date_installation = 'octobre 2013'  THEN CAST('2013-10-01' AS DATE)
        WHEN date_installation = 'mars 2014'     THEN CAST('2014-03-01' AS DATE)
        WHEN date_installation = 'février 2015'  THEN CAST('2015-02-01' AS DATE)
        WHEN date_installation = 'juillet 2016'  THEN CAST('2016-07-01' AS DATE)
        WHEN date_installation = 'décembre 2016' THEN CAST('2016-12-01' AS DATE)
        WHEN date_installation = 'mai 2017'      THEN CAST('2017-05-01' AS DATE)
        WHEN date_installation = 'janvier 2019'  THEN CAST('2019-01-01' AS DATE)
        WHEN date_installation = 'novembre 2019' THEN CAST('2019-11-01' AS DATE)
        WHEN date_installation = 'février 2020'  THEN CAST('2020-02-01' AS DATE)
        WHEN date_installation = 'février 2021'  THEN CAST('2021-02-01' AS DATE)
        WHEN date_installation = 'octobre 2021'  THEN CAST('2021-10-01' AS DATE)
        WHEN date_installation = 'novembre 2021' THEN CAST('2021-11-01' AS DATE)
        WHEN date_installation = 'décembre 2021' THEN CAST('2021-12-01' AS DATE)
        WHEN date_installation = 'mai 2022'      THEN CAST('2022-05-01' AS DATE)
        WHEN date_installation = 'juin 2022'     THEN CAST('2022-06-01' AS DATE)
        WHEN date_installation = 'juillet 2022'  THEN CAST('2022-07-01' AS DATE)
        WHEN date_installation = 'décembre 2022' THEN CAST('2022-12-01' AS DATE)
        WHEN date_installation = 'février 2023'  THEN CAST('2023-02-01' AS DATE)
        WHEN date_installation = 'mars 2023'     THEN CAST('2023-03-01' AS DATE)
        WHEN date_installation = 'avril 2023'    THEN CAST('2023-04-01' AS DATE)
        WHEN date_installation = 'mai 2023'      THEN CAST('2023-05-01' AS DATE)
        WHEN date_installation = 'juin 2023'     THEN CAST('2023-06-01' AS DATE)
        ELSE NULL
END AS date, remarques,
e.id AS etat_id,
tm.id AS type_materiau_id,
tml.id AS type_materiel_id
FROM
    staging.inventaire_mobilier AS inv
LEFT JOIN 
    public.etat AS e ON inv.etat = e.libelle
LEFT JOIN 
public.type_materiau AS tm ON inv.type_materiau = tm.libelle
LEFT JOIN 
public.type_materiel AS tml ON inv.type_materiel = tml.libelle;