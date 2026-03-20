-- Active: 1772189481213@@127.0.0.1@5432@budget
CREATE SCHEMA staging;

CREATE TABLE staging.inventaire_mobilier (
    numero TEXT,
    type_materiel TEXT,
    type_materiau TEXT,
    lieu TEXT,
    latitude TEXT,
    longitude TEXT,
    date_installation TEXT,
    etat TEXT,
    remarques TEXT
);

CREATE TABLE staging.signalements (
    date TEXT,
    signale_par TEXT,
    objet TEXT,
    description TEXT,
    urgent TEXT,
    statut TEXT
);

CREATE TABLE staging.interventions (
    date TEXT,
    objet TEXT,
    type_intervention TEXT,
    technicien TEXT,
    duree TEXT,
    cout_materiel TEXT,
    remarques TEXT
);

CREATE TABLE staging.fournisseurs_contact (
    entreprise TEXT,
    contact TEXT,
    telephone TEXT,
    email TEXT,
    type_materiel TEXT,
    remarques TEXT
);

COPY staging.inventaire_mobilier
FROM '/data/inventaire_mobilier.csv'
WITH (FORMAT csv, HEADER true,
      DELIMITER ';', ENCODING 'UTF8');


COPY staging.signalements
FROM '/data/signalements.csv'
WITH (FORMAT csv, HEADER true,
      DELIMITER ';', ENCODING 'UTF8');

COPY staging.fournisseurs_contact
FROM '/data/fournisseurs_contacts.csv'
WITH (FORMAT csv, HEADER true,
      DELIMITER ';', ENCODING 'UTF8');

COPY staging.interventions
FROM '/data/interventions.csv'
WITH (FORMAT csv, HEADER true,
      DELIMITER ';', ENCODING 'UTF8');