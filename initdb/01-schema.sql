CREATE TABLE etat (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE type_materiau (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE type_materiel (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE statut (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE type_intervention (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE inventaire_mobilier (
    id SERIAL PRIMARY KEY,
    numero INTEGER,
    lieu TEXT NOT NULL,
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    date_installation DATE NOT NULL,
    remarques TEXT,
    id_etat INT,
    id_type_materiau INT,
    id_type_materiel INT,
    FOREIGN KEY (id_etat) REFERENCES etat (id),
    FOREIGN KEY (id_type_materiau) REFERENCES type_materiau (id),
    FOREIGN KEY (id_type_materiel) REFERENCES type_materiel (id)
);

CREATE TABLE signalements (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    civilite VARCHAR (10),
    nom VARCHAR(100) NOT NULL,
    description TEXT,
    urgent BOOLEAN,
    id_statut INT,
    id_inventaire_mobilier INT,
    FOREIGN KEY (id_statut) REFERENCES statut (id),
    FOREIGN KEY (id_inventaire_mobilier) REFERENCES inventaire_mobilier (id)
);

CREATE TABLE interventions (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    technicien_nom VARCHAR(100) NOT NULL,
    technicien_prenom VARCHAR(100),
    duree_heures DECIMAL(5, 2) NOT NULL,
    cout_materiel_chf DECIMAL(10, 2) NOT NULL,
    remarques TEXT,
    id_inventaire_mobilier INT,
    id_type_intervention INT,
    FOREIGN KEY (id_inventaire_mobilier) REFERENCES inventaire_mobilier (id),
    FOREIGN KEY (id_type_intervention) REFERENCES type_intervention (id)
);

CREATE TABLE fournisseurs_contact (
    id SERIAL PRIMARY KEY,
    nom_entreprise VARCHAR(100) NOT NULL,
    contact_nom VARCHAR(100) NOT NULL,
    contact_prenom VARCHAR(100),
    telephone VARCHAR(10),
    email VARCHAR(150) CHECK (email LIKE '%@%') NOT NULL,
    remarques TEXT
);

CREATE TABLE fournisseurs_type_materiel (
    id SERIAL PRIMARY KEY,
    id_fournisseur INT NOT NULL,
    id_type_materiel INT NOT NULL,
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseurs_contact (id),
    FOREIGN KEY (id_type_materiel) REFERENCES type_materiel (id)
);
