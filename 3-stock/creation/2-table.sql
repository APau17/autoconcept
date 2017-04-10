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
# Table: Compatibilité
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Compatibilite  (
        id                   Int NOT NULL,
        Modele_de_voiture_id Int NOT NULL,
        PRIMARY KEY (id, Modele_de_voiture_id)
) ;
