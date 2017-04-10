#------------------------------------------------------------
# Table: Adresse
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Adresse (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        adresse Varchar(100) NOT NULL,
        ville Varchar (50) NOT NULL,
        codePostal Varchar (6) NOT NULL,

		#Constraints
        CONSTRAINT discriminant UNIQUE(adresse, ville, codePostal)
        COMMENT "L'alliance d'une adresse, d'une ville et d'un code postal doit etre unique"
);

#------------------------------------------------------------
# Table: Entreprise
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Entreprise (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        raisonSociale Varchar (50) NOT NULL,

        siret         Varchar (14) NOT NULL UNIQUE,

        logo Text
        COMMENT 'Uri vers le logo',

        parent_id Int
        COMMENT 'Maison mère',

        # FK
        Adresse_id Int NOT NULL
        COMMENT 'Adresse du siege sociale',
        FOREIGN KEY (Adresse_id) REFERENCES Adresse(id)
);

#------------------------------------------------------------
# Table: Contact
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Contact (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (50) NOT NULL,
        prenom Varchar (50) NOT NULL,

        sexe Boolean
        COMMENT '0 pour les hommes. 1 pour les femmes',

        dateNaiss Date
        COMMENT 'Date de naissance',

		courriel Varchar (50),

        telephone Varchar(10)
        COMMENT 'Format avec dix chiffres sans delimiteur',

        #Constraints
        CONSTRAINT discriminant UNIQUE(nom, prenom, dateNaiss)
        COMMENT "L'alliance d'un nom, prenom et date de naissance doit etre unique"
);

#------------------------------------------------------------
# Table: Droit
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Droit (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar(50) UNIQUE,

        facturable Boolean NOT NULL
        DEFAULT 1,

        livrable Boolean NOT NULL
        DEFAULT 1
);

#------------------------------------------------------------
# Table: Partenaire
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Partenaire (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        Contact_id Int NOT NULL,
        Entreprise_id Int,
        Droit_id Int NOT NULL,

        #Constraints
        CONSTRAINT discriminant UNIQUE(Contact_id, Entreprise_id, Droit_id),

        # FK
        FOREIGN KEY (Entreprise_id) REFERENCES Contact(id),
        FOREIGN KEY (Contact_id) REFERENCES Contact(id),
        FOREIGN KEY (Droit_id) REFERENCES Droit(id)
);

#------------------------------------------------------------
# Table: Modèle de voiture
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_voiture (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        modele Varchar (50),
        classe Varchar (50),
        annee Date,
        motorisation Varchar (50),
        carburantEnergie Varchar (50),

        # FK
        Entreprise_id Int
        COMMENT 'Marque',
        FOREIGN KEY (Entreprise_id) REFERENCES Entreprise(id)
);

#------------------------------------------------------------
# Table: Voiture client
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Voiture_client (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        immatriculation Varchar (25),
        dateMiseEnCirculation Date,

        dateCreation DATETIME DEFAULT CURRENT_TIMESTAMP,
        dateModification DATETIME DEFAULT CURRENT_TIMESTAMP,

        # Index
        INDEX immatriculation_index (immatriculation),

        # Keys
        parent_id Int
        COMMENT "Si null, proprietaire actuelle. Sinon nouveau proprietaire.",

        # FK
        Partenaire_id Int NOT NULL,
        Modele_de_voiture_id Int,
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id),
        FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id)
);

#------------------------------------------------------------
# Table: Fiche salarié
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Fiche_salarie  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateEmbauche Date,
        service Varchar (25),

        #FK
    	Contact_id int NOT NULL,
        Partenaire_id int NOT NULL,
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id),
        FOREIGN KEY (Contact_id) REFERENCES Contact(id)
);

#------------------------------------------------------------
# Table: Partenaire_Adresse
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Partenaire_Adresse  (
        Adresse_id Int NOT NULL,
        Partenaire_id Int NOT NULL,

        FOREIGN KEY (Adresse_id) REFERENCES Adresse(id),
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id)
);
