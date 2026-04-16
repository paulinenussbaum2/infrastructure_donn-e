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
    numero INTEGER NOT NULL,
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
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100),
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
    cout_materiel DECIMAL(10, 2) NOT NULL,
    remarques TEXT,
    statut_intervention VARCHAR(100) UNIQUE NOT NULL,
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
    remarques TEXT,
    id_type_materiel INT,
    FOREIGN KEY (id_type_materiel) REFERENCES type_materiel (id)
);

CREATE TABLE fournisseurs_inventaire (
    id SERIAL PRIMARY KEY,
    id_fournisseurs INT NOT NULL,
    id_inventaire INT NOT NULL,
    FOREIGN KEY (id_fournisseurs) REFERENCES fournisseurs_contact (id),
    FOREIGN KEY (id_inventaire) REFERENCES inventaire_mobilier (id)
);

CREATE TABLE interventions_fournisseurs (
    id SERIAL PRIMARY KEY,
    id_fournisseurs_contact INT NOT NULL,
    id_interventions INT NOT NULL,
    FOREIGN KEY (id_fournisseurs_contact) REFERENCES fournisseurs_contact (id),
    FOREIGN KEY (id_interventions) REFERENCES interventions (id)
);