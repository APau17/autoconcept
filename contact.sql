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

        #Constraints
        CONSTRAINT discriminant UNIQUE(nom, prenom, dateNaiss)
        COMMENT "L'alliance d'un nom, prenom et date de nassaissance doit etre unique"
);

#------------------------------------------------------------
# Table: Adresse
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Adresse (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        adresse Text NOT NULL,
        ville Varchar (50) NOT NULL,
        code_postal Varchar (9) NOT NULL,

        #FK
    	Contact_id int NOT NULL,
        FOREIGN KEY (Contact_id) REFERENCES Contact(id) ON DELETE CASCADE
) COMMENT "Une addresse est n'est pas unique. Elle est associee a un contact.";


#------------------------------------------------------------
# Table: Modèle de voiture
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_voiture (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        marque Varchar (50),
        modele Varchar (50),
        classe Varchar (50),
        annee Date,
        motorisation Varchar (50),
        carburantEnergie Varchar (50)
);

#------------------------------------------------------------
# Table: Voiture client
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Voiture_client (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        immatriculation Varchar (25),
        dateMiseEnCirculation Date,

        # Index
        INDEX immatriculation_index (immatriculation),

        # FK
        Contact_id Int NOT NULL,
        Modele_de_voiture_id Int,
        FOREIGN KEY (Contact_id) REFERENCES Contact(id),
        FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id) ON DELETE SET NULL
);

#------------------------------------------------------------
# Table: Entreprise
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Entreprise (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        raisonSociale Varchar (50) NOT NULL,
        siret         Varchar (14) NOT NULL,

        #FK
    	Adresse_id int,
        FOREIGN KEY (Adresse_id) REFERENCES Adresse(id)
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
        FOREIGN KEY (Contact_id) REFERENCES Contact(id)
);


#------------------------------------------------------------
# Table: Contact_Entreprise
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Contact_Entreprise  (
        id Int,
        Contact_id Int,
        Entreprise_id Int,

        FOREIGN KEY (Contact_id) REFERENCES Contact(id),
        FOREIGN KEY (Entreprise_id) REFERENCES Entreprise(id)
);
