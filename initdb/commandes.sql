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
WHEN LOWER (TRIM(type_materiau)) LIKE '%led%' then 'LED'
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


INSERT INTO inventaire_mobilier (numero, lieu, latitude, longitude, date_installation, remarques, id_etat, id_type_materiau, id_type_materiel)
SELECT
CASE
    WHEN numero LIKE 'B-%'   THEN CAST(REPLACE(numero, 'B-', '') AS INTEGER)
    WHEN numero LIKE 'B_%'   THEN CAST(REPLACE(numero, 'B_', '') AS INTEGER)
    WHEN numero LIKE 'L-%'   THEN CAST(REPLACE(numero, 'L-', '') AS INTEGER)
    WHEN numero LIKE 'EV_%'  THEN CAST(REPLACE(numero, 'EV_', '') AS INTEGER)
    WHEN numero LIKE 'PA-%'  THEN CAST(REPLACE(numero, 'PA-', '') AS INTEGER) --- Ligné changée
    WHEN numero LIKE 'P-%'   THEN CAST(REPLACE(numero, 'P-', '') AS INTEGER)
    WHEN numero LIKE 'L_%'   THEN CAST(REPLACE(numero, 'L_', '') AS INTEGER)
    WHEN numero LIKE 'P_%'   THEN CAST(REPLACE(numero, 'P_', '') AS INTEGER)
    WHEN numero LIKE 'F-%'   THEN CAST(REPLACE(numero, 'F-', '') AS INTEGER)  --- Ligné changée
    ELSE CAST(numero AS INTEGER)
    --ELSE NULL
END,lieu, REPLACE(latitude, ',', '.')::NUMERIC(9,6),REPLACE(longitude, ',', '.')::NUMERIC(9,6),
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
tm.id AS id_type_materiau,
tml.id AS id_type_materiel
FROM
    staging.inventaire_mobilier AS inv
LEFT JOIN public.etat AS e 
    ON e.libelle = CASE
        WHEN LOWER(TRIM(inv.etat)) LIKE '%usé%'        THEN 'usé'
        WHEN LOWER(TRIM(inv.etat)) LIKE '%bon%'         THEN 'bon'
        WHEN LOWER(TRIM(inv.etat)) LIKE '%remplacer%'   THEN 'à remplacer'
        ELSE NULL
    END
LEFT JOIN public.type_materiau AS tm 
    ON tm.libelle = CASE
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%bois%'   THEN 'bois'
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%métal%'  THEN 'métal'
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%metal%'  THEN 'métal'
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%sodium%' THEN 'sodium'
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%led%'    THEN 'LED'
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%pierre%' THEN 'pierre'
        WHEN LOWER(TRIM(inv.type_materiau)) LIKE '%béton%'  THEN 'béton'
        ELSE NULL
    END
LEFT JOIN public.type_materiel AS tml 
    ON tml.libelle = CASE
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%banc%'       THEN 'banc'
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%lampadaire%' THEN 'lampadaire'
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%corbeille%'  THEN 'poubelle'
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%poubelle%'   THEN 'poubelle'
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%fontaine%'   THEN 'fontaine'
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%borne%'      THEN 'borne recharge'
        WHEN LOWER(TRIM(inv.type_materiel)) LIKE '%panneau%'    THEN 'panneau'
        ELSE NULL
    END;



INSERT INTO fournisseurs_contact (nom_entreprise, contact_nom, contact_prenom, telephone, email, remarques)
SELECT
    entreprise,
    CASE
        WHEN LOWER(TRIM(contact)) LIKE '%steiner%'  THEN 'Steiner'
        WHEN LOWER(TRIM(contact)) LIKE '%keller%'   THEN 'Keller'
        WHEN LOWER(TRIM(contact)) LIKE '%rochat%'   THEN 'Rochat'
        WHEN LOWER(TRIM(contact)) LIKE '%müller%'   THEN 'Müller'
        WHEN LOWER(TRIM(contact)) LIKE '%weber%'    THEN 'Weber'
        WHEN LOWER(TRIM(contact)) LIKE '%roth%'     THEN 'Roth'
        WHEN LOWER(TRIM(contact)) LIKE '%da silva%' THEN 'Da Silva'
        WHEN LOWER(TRIM(contact)) LIKE '%alain%'    THEN 'À compléter'
        WHEN LOWER(TRIM(contact)) LIKE '%robert%'   THEN 'À compléter'
        WHEN LOWER(TRIM(contact)) LIKE '%jean-paul%' THEN 'À compléter'
        WHEN contact IS NULL OR TRIM(contact) = ''  THEN 'À compléter'
        WHEN LOWER(TRIM(contact)) LIKE '%voir site web%' THEN 'À compléter'
        WHEN LOWER(TRIM(contact)) LIKE '%secrétariat%'   THEN 'À compléter'
        ELSE 'À compléter'
    END AS contact_nom,
    CASE
        WHEN LOWER(TRIM(contact)) LIKE '%thomas%'    THEN 'Thomas'
        WHEN LOWER(TRIM(contact)) LIKE '%jean-paul%' THEN 'Jean-Paul'
        WHEN LOWER(TRIM(contact)) LIKE '%marc%'      THEN 'Marc'
        WHEN LOWER(TRIM(contact)) LIKE '%alain%'     THEN 'Alain'
        WHEN LOWER(TRIM(contact)) LIKE '%robert%'    THEN 'Robert'
        ELSE NULL
    END AS contact_prenom,

CASE WHEN TRIM(s.telephone) IS NOT NULL THEN
    REGEXP_REPLACE(
        REGEXP_REPLACE(TRIM(s.telephone), '^\+41\s*', '0'),
    '\s', '', 'g')
END AS telephone,

    CASE
        WHEN email LIKE '%@%' THEN LOWER(TRIM(email))
        ELSE '@À compléter'
    END AS email,

    NULLIF(TRIM(remarques), '') AS remarques
FROM staging.fournisseurs_contact s;


INSERT INTO interventions (date, technicien_nom, technicien_prenom, duree_heures, cout_materiel_chf, remarques, id_type_intervention, id_inventaire_mobilier)
SELECT
    CASE
        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(s.date, 'DD.MM.YYYY')
        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'   THEN TO_DATE(s.date, 'YYYY-MM-DD')
    END AS date,

    CASE
        WHEN LOWER(TRIM(s.technicien)) IN ('jm', 'jean-marc', 'jean-marc bonvin') THEN 'Bonvin'
        WHEN LOWER(TRIM(s.technicien)) IN ('pedro', 'p. alves', 'alves pedro')    THEN 'Alves'
        WHEN LOWER(TRIM(s.technicien)) = 'koffi marc'                              THEN 'Koffi'
        WHEN LOWER(TRIM(s.technicien)) = 'stagiaire'                               THEN 'Stagiaire'
        ELSE TRIM(s.technicien)
    END AS technicien_nom,

    CASE
        WHEN LOWER(TRIM(s.technicien)) IN ('jm', 'jean-marc', 'jean-marc bonvin') THEN 'Jean-Marc'
        WHEN LOWER(TRIM(s.technicien)) IN ('pedro', 'p. alves', 'alves pedro')    THEN 'Pedro'
        WHEN LOWER(TRIM(s.technicien)) = 'koffi marc'                              THEN 'Marc'
        ELSE NULL
    END AS technicien_prenom,

    CASE
        WHEN LOWER(TRIM(s.duree)) = '30 min'      THEN 0.5
        WHEN LOWER(TRIM(s.duree)) = '1h'          THEN 1.0
        WHEN LOWER(TRIM(s.duree)) = '1h30'        THEN 1.5
        WHEN LOWER(TRIM(s.duree)) = '2h'          THEN 2.0
        WHEN LOWER(TRIM(s.duree)) = '3h'          THEN 3.0
        WHEN LOWER(TRIM(s.duree)) = 'une matinée' THEN 4.0
        WHEN LOWER(TRIM(s.duree)) = 'une journée' THEN 8.0
        ELSE NULL
    END AS duree_heures,

    CASE
        WHEN LOWER(TRIM(s.cout_materiel)) IN ('garantie', 'gratuit') THEN 0.00
        WHEN TRIM(s.cout_materiel) = '' OR s.cout_materiel IS NULL   THEN 0.00
        ELSE CAST(
            REGEXP_REPLACE(
                REGEXP_REPLACE(TRIM(s.cout_materiel), '^CHF\s*', ''),
            '\.-$', '')
        AS DECIMAL(10,2))
    END AS cout_materiel_chf,


    NULLIF(TRIM(s.remarques), '') AS remarques,


    ti.id AS id_type_intervention,

    im.id AS id_inventaire_mobilier

FROM staging.interventions s

LEFT JOIN public.type_intervention ti
    ON ti.libelle = CASE
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%peinture%'          THEN 'peinture'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%réparation%'        THEN 'réparation'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%remise en service%' THEN 'réparation'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%remplacement%'      THEN 'remplacement'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%nettoyage%'         THEN 'nettoyage'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%hivernage%'         THEN 'hivernage'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%détartrage%'        THEN 'détartrage'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%mise à jour%'       THEN 'mise à jour logiciel'
        WHEN LOWER(TRIM(s.type_intervention)) LIKE '%redressage%'        THEN 'réparation'
        ELSE NULL
    END


LEFT JOIN public.inventaire_mobilier im
    ON im.lieu ILIKE '%' || REGEXP_REPLACE(
            TRIM(s.objet),
            '^(banc\s+public\s+|banc\s+|lampadaire\s+led\s+|lampadaire\s+sodium\s+|lampadaire\s+|fontaine\s+publique\s+|fontaine\s+|poubelle\s+tri\s+|poubelle\s+|borne\s+recharge\s+ev\s+|borne\s+ev\s+|panneau\s+info\s+|panneau\s+)',
            '', 'i'
        ) || '%'
    AND im.id_type_materiel = (
        SELECT id FROM public.type_materiel WHERE libelle =
            CASE
                WHEN LOWER(s.objet) LIKE '%banc%'       THEN 'banc'
                WHEN LOWER(s.objet) LIKE '%lampadaire%' THEN 'lampadaire'
                WHEN LOWER(s.objet) LIKE '%fontaine%'   THEN 'fontaine'
                WHEN LOWER(s.objet) LIKE '%poubelle%'   THEN 'poubelle'
                WHEN LOWER(s.objet) LIKE '%borne%'      THEN 'borne recharge'
                WHEN LOWER(s.objet) LIKE '%panneau%'    THEN 'panneau'
                ELSE NULL
            END
    );


   INSERT INTO public.signalements (
    date,
    civilite,
    nom,
    description,
    urgent,
    id_statut,
    id_inventaire_mobilier)
SELECT
    CASE
        WHEN s.date ~ '^\d{2}\.\d{2}\.\d{4}$' THEN TO_DATE(s.date, 'DD.MM.YYYY')
        WHEN s.date ~ '^\d{4}-\d{2}-\d{2}$'   THEN TO_DATE(s.date, 'YYYY-MM-DD')
    END AS date,
    CASE
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%mme%'  THEN 'Mme'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%m. %'  THEN 'M.'
        ELSE NULL
    END AS civilite,
    CASE
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%weber%'            THEN 'Weber'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%rochat%'           THEN 'Rochat'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%dupont%'           THEN 'Dupont'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%pereira%'          THEN 'Pereira'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%patrouille%'       THEN 'Patrouille'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%concierge%'        THEN 'Concierge école'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%email citoyen%'    THEN 'Inconnu'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%passant%'          THEN 'Inconnu'
        WHEN LOWER(TRIM(s.signale_par)) LIKE '%habitant%'         THEN 'Inconnu'
        WHEN s.signale_par IS NULL OR TRIM(s.signale_par) = ''    THEN 'Inconnu'
        ELSE TRIM(s.signale_par)
    END AS nom,

    NULLIF(TRIM(s.description), '') AS description,

   CASE
    WHEN LOWER(TRIM(s.urgent)) = 'urgent'       THEN TRUE
    WHEN LOWER(TRIM(s.urgent)) = 'normal'       THEN FALSE
    WHEN s.urgent IS NULL OR TRIM(s.urgent) = '' THEN FALSE
    ELSE FALSE
END AS urgent,

    st.id AS id_statut,

    im.id AS id_inventaire_mobilier

FROM staging.signalements s

LEFT JOIN public.statut st
    ON st.libelle = CASE
        WHEN LOWER(TRIM(s.statut)) LIKE '%en attente%' THEN 'en cours'
        WHEN LOWER(TRIM(s.statut)) LIKE '%en cours%'   THEN 'en cours'
        WHEN LOWER(TRIM(s.statut)) LIKE '%fait%'        THEN 'fait'
        ELSE 'en cours'
    END

LEFT JOIN public.inventaire_mobilier im
    ON im.lieu ILIKE '%' || REGEXP_REPLACE(
            TRIM(s.objet),
            '^(le\s+|la\s+|les\s+)?(banc\s+public\s+|banc\s+|lampadaire\s+led\s+|lampadaire\s+sodium\s+|lampadaire\s+|fontaine\s+publique\s+|fontaine\s+|poubelle\s+tri\s+|poubelle\s+|corbeille\s+|borne\s+recharge\s+ev\s+|borne\s+ev\s+|borne\s+|panneau\s+info\s+|panneau\s+)(près\s+de\s+|devant\s+|du\s+|de\s+la\s+|de\s+)?',
            '', 'i'
        ) || '%'
    AND im.id_type_materiel = (
        SELECT id FROM public.type_materiel WHERE libelle =
            CASE
                WHEN LOWER(s.objet) LIKE '%banc%'       THEN 'banc'
                WHEN LOWER(s.objet) LIKE '%lampadaire%' THEN 'lampadaire'
                WHEN LOWER(s.objet) LIKE '%fontaine%'   THEN 'fontaine'
                WHEN LOWER(s.objet) LIKE '%poubelle%'   THEN 'poubelle'
                WHEN LOWER(s.objet) LIKE '%corbeille%'  THEN 'poubelle'
                WHEN LOWER(s.objet) LIKE '%borne%'      THEN 'borne recharge'
                WHEN LOWER(s.objet) LIKE '%panneau%'    THEN 'panneau'
            END
    );

INSERT INTO fournisseurs_type_materiel (id_fournisseur, id_type_materiel)
SELECT DISTINCT
    fc.id AS id_fournisseurs_contact,
    tme.id AS id_type_materiel
FROM staging.fournisseurs_contact s
JOIN fournisseurs_contact fc ON fc.nom_entreprise = s.entreprise
JOIN type_materiel tme ON (
    (LOWER(s.type_materiel) LIKE '%banc%'       AND tme.libelle = 'banc')       OR
    (LOWER(s.type_materiel) LIKE '%lampadaire%' AND tme.libelle = 'lampadaire') OR
    (LOWER(s.type_materiel) LIKE '%éclairage%'  AND tme.libelle = 'lampadaire') OR
    (LOWER(s.type_materiel) LIKE '%fontaine%'   AND tme.libelle = 'fontaine')   OR
    (LOWER(s.type_materiel) LIKE '%poubelle%'   AND tme.libelle = 'poubelle')   OR
    (LOWER(s.type_materiel) LIKE '%borne%'      AND tme.libelle = 'borne recharge') OR
    (LOWER(s.type_materiel) LIKE '%panneau%'    AND tme.libelle = 'panneau')
);

