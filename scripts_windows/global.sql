DROP DATABASE IF EXISTS autoconcept;
CREATE DATABASE IF NOT EXISTS autoconcept;
USE autoconcept;
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
#------------------------------------------------------------
# Table: Bon de commande
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Bon_de_commande (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateCreation Date
        COMMENT 'Si non null, alors la commande est engagee',

        dateAchat Date
        COMMENT 'Si non null, alors la commande peut etre livree',

        dateLivraison Date
        COMMENT 'Si non null, alors la commande est finalisee',

        remise DECIMAL (3, 2)
        COMMENT 'Pourcentage',

        # Keys
        Partenaire_Fournisseur_id Int NOT NULL,
        Partenaire_Client_id Int NOT NULL,
        FOREIGN KEY (Partenaire_Fournisseur_id) REFERENCES Partenaire(id),
        FOREIGN KEY (Partenaire_Client_id) REFERENCES Partenaire(id)
);

#------------------------------------------------------------
# Table: Litige
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Litige  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateLitige Date,

        commentaire Text
        COMMENT 'Commentaire libre',

        # Keys
        Bon_de_commande_id_origine Int
        COMMENT 'Bon de commmande provoquant le litige',

        Bon_de_commande_id_resolution Int
        COMMENT 'Bon de commmande qui résoud le litige',

        FOREIGN KEY (Bon_de_commande_id_origine) REFERENCES Bon_de_commande(id),
        FOREIGN KEY (Bon_de_commande_id_resolution) REFERENCES Bon_de_commande(id)
);

#------------------------------------------------------------
# Table: Ligne de commande
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Ligne_de_commande  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        prixUnitaire DECIMAL (15, 2),

        quantiteCommandee Int
        COMMENT 'Champ calcule',

        quantiteLivree    Int
        COMMENT 'Champ calcule',

        # Keys
        Bon_de_commande_id Int,
        FOREIGN KEY (Bon_de_commande_id) REFERENCES Bon_de_commande(id)
);
#------------------------------------------------------------
# Table: Unite
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Unite  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (25) NOT NULL UNIQUE,

        ratio Float
        COMMENT 'Ratio entre les unites',

        # Keys
        Unite_base_id Int
);
#------------------------------------------------------------
# Table: Modèle de pièce
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_piece  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (50) NOT NULL UNIQUE
        COMMENT '',

        designation Varchar (120)
        COMMENT '',

        prixUnitaire DECIMAL(15, 2) NOT NULL
        COMMENT 'En euros. Il ne peut pas etre inferieur a zero',

        restriction Text
        COMMENT 'Commentaire libre',

        compatibiliteApplication Text
        COMMENT 'Commentaire libre',

        commentaire Text
        COMMENT 'Commentaire libre',

        fichePdf Text
        COMMENT 'URL vers la documentation',

        referenceConstructeur Text
        COMMENT 'Le format est libre',

        # Keys
        Unite_id Int,
        FOREIGN KEY (Unite_id) REFERENCES Unite(id)
);


#------------------------------------------------------------
# Table: Emplacement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Emplacement  (
        id Int PRIMARY KEY NOT NULL,
        nom Varchar(50),

        # Keys
        parent_id Int NOT NULL
        COMMENT 'Recursive emplacement'
);

#------------------------------------------------------------
# Table: Lot
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Lot  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        numeroFournisseur Varchar(50)
        UNIQUE,

        quantite Int NOT NULL
        COMMENT 'Ne peut pas etre inferieur a zero',

        # Keys
        Emplacement_id Int NOT NULL,
        Modele_de_piece_id Int NOT NULL,
        Unite_id Int NOT NULL,
        FOREIGN KEY (Emplacement_id) REFERENCES Emplacement(id),
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id),
        FOREIGN KEY (Unite_id) REFERENCES Unite(id)
) ;

#------------------------------------------------------------
# Table: Mouvement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Mouvement  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateMouvement Date,

        # Keys
        Emplacement_id Int NOT NULL
        COMMENT 'Nouvelle emplacement du lot',

        Lot_id Int NOT NULL,
        Unite_id Int NOT NULL,
        FOREIGN KEY (Emplacement_id) REFERENCES Emplacement(id),
        FOREIGN KEY (Lot_id) REFERENCES Lot(id),
        FOREIGN KEY (Unite_id) REFERENCES Unite(id)
) ;


#------------------------------------------------------------
# Table: Compatibilité
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Compatibilite  (
        id                   Int NOT NULL,
        Modele_de_voiture_id Int NOT NULL,
        PRIMARY KEY (id, Modele_de_voiture_id)
) ;
#------------------------------------------------------------
# Table: Categorie Piece
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Categorie_piece (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (50) NOT NULL,

        lft Int
        COMMENT 'Minimal interval enfants',

        rgt Int
        COMMENT 'Maximal interval enfants',

        # Keys
        Modele_de_piece_id Int,
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id)
);
