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
# Table: Dépendance
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Dependance  (
        Modele_de_piece_id Int NOT NULL,
        Modele_de_piece_id_dependre Int NOT NULL,
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id),
        FOREIGN KEY (Modele_de_piece_id_dependre) REFERENCES Modele_de_piece(id)
) ;

#------------------------------------------------------------
# Table: Emplacement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Emplacement  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar(50),
        virtuel Boolean,

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
        parent_id Int NOT NULL
        COMMENT 'Nouvelle emplacement du lot',

        Emplacement_id Int NOT NULL,
        Lot_id Int NOT NULL,
        Partenaire_id Int NOT NULL,

        FOREIGN KEY (Emplacement_id) REFERENCES Emplacement(id),
        FOREIGN KEY (Lot_id) REFERENCES Lot(id),
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id)
) ;


#------------------------------------------------------------
# Table: Compatibilité
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Compatibilite  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        # Keys
        Modele_de_voiture_id Int NOT NULL,
        FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id)
) ;
