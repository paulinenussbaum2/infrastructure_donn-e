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



SELECT DISTINCT (
    CASE
    WHEN date_installation LIKE '%.%.%'
        THEN TO_DATE(date_installation, 'DD.MM.YYYY')
    WHEN date_installation LIKE '____-__-__'
        THEN TO_DATE(date_installation, 'YYYY-MM-DD')
    ELSE NULL
END
)
FROM staging.inventaire_mobilier;

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


SELECT DISTINCT 
CASE 
WHEN LOWER (TRIM ())