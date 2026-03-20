SELECT DISTINCT (
    CASE when type_materiel LIKE '%anc%' then 'banc'
    when type_materiel LIKE '%ampadaire%' then 'lampadaire'
    when type_materiel lIKE '%oubelle%' then 'poubelle'
    when type_materiel lIKE 'corbeille%' then 'poubelle'
    when type_materiel lIKE '%ontaine%' then 'fontaine'
    when type_materiel lIKE '%orne%' then 'borne recharge'
    when type_materiel lIKE '%anneau%' then 'panneau'
    ELSE NULL
    END
    )
FROM staging.inventaire_mobilier;

SELECT DISTINCT (
    CASE when type_materiau LIKE '%ois%' then 'bois'
    when type_materiau LIKE '%étal%' then 'metal'
    when type_materiau LIKE '%etal%' then 'metal'
    when type_materiau LIKE '%odium%' then 'sodium'
    when type_materiau LIKE 'LED%' then 'LED'
    when type_materiau LIKE 'led%' then 'LED'
    when type_materiau LIKE '%ierre%' then 'pierre'
    when type_materiau LIKE '%éton%' then 'pierre'
    ELSE NULL
    END
    ), type_materiau
FROM staging.inventaire_mobilier;

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

SELECT DISTINCT (
    CASE when etat LIKE 'usé' then 'usé'
    when etat LIKE 'bon' then 'bon'
    when etat LIKE 'à remplacer' then 'à remplacer'
    ELSE NULL
    END
    )
FROM staging.inventaire_mobilier;
