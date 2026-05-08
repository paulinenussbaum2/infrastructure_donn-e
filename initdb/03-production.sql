CREATE VIEW v_budget_par_type AS
SELECT
    EXTRACT(YEAR FROM i.date)        AS annee,
    tme.libelle                       AS type_mobilier,
    COUNT(i.id)                       AS nb_interventions,
    SUM(i.cout_materiel_chf)          AS cout_total,
    ROUND(AVG(i.cout_materiel_chf), 2) AS cout_moyen
FROM interventions i
JOIN inventaire_mobilier im ON im.id = i.id_inventaire_mobilier
JOIN type_materiel tme      ON tme.id = im.id_type_materiel
WHERE EXTRACT(YEAR FROM i.date) IN (2024, 2025)
GROUP BY annee, tme.libelle
ORDER BY annee, cout_total DESC;

SELECT * FROM v_budget_par_type;


CREATE VIEW v_top5_couteux AS
SELECT
    tme.libelle          AS type_mobilier,
    im.lieu,
    im.latitude,
    im.longitude,
    COUNT(i.id)          AS nb_interventions,
    SUM(i.cout_materiel_chf) AS cout_cumule
FROM interventions i
JOIN inventaire_mobilier im ON im.id = i.id_inventaire_mobilier
JOIN type_materiel tme      ON tme.id = im.id_type_materiel
GROUP BY tme.libelle, im.lieu, im.latitude, im.longitude
ORDER BY cout_cumule DESC
LIMIT 5;

SELECT * FROM v_top5_couteux;

CREATE VIEW v_saisonnalite AS
SELECT
    EXTRACT(MONTH FROM i.date)                    AS mois,
    TO_CHAR(i.date, 'Month')                      AS nom_mois,
    COUNT(i.id)                                   AS nb_interventions,
    SUM(i.cout_materiel_chf)                      AS cout_total
FROM interventions i
GROUP BY mois, nom_mois
ORDER BY mois;

SELECT * FROM v_saisonnalite;
