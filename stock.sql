#------------------------------------------------------------
# Table: Lot
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Lot  (
        id                 int (11) Auto_increment  NOT NULL,

        numeroFournisseur  Varchar (50) UNIQUE,

        quantite           Varchar (25) NOT NULL
        COMMENT 'Ne peut pas etre inferieur a zero',

        unite              Varchar (25) NOT NULL,

        Modele_de_piece_id Int,

        # Keys
        PRIMARY KEY (id),

        # Constraints
        CHECK(quantite > 0)
) ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Modèle de pièce
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_piece  (
        id                       Int Auto_increment  NOT NULL,

        nom                      Varchar (50) NOT NULL UNIQUE
        COMMENT '',

        designation              Varchar (120)
        COMMENT '',

        marque                   Varchar (50)
        COMMENT '',

        prixUnitaire             DECIMAL(15, 2) NOT NULL
        COMMENT 'En euros. Il ne peut pas etre inferieur a zero',

        restriction              Text
        COMMENT 'Commentaire libre',

        compatibiliteApplication Text
        COMMENT 'Commentaire libre',

        commentaire              Text
        COMMENT 'Commentaire libre',

        fichePdf                 Varchar (250) UNIQUE
        COMMENT 'URL vers la documentation',

        referanceConstructor     Varchar (25) UNIQUE
        COMMENT 'Le format est libre',

        lft                      Int NOT NULL
        COMMENT 'Minimal interval enfants',

        rgt                      Int NOT NULL
        COMMENT 'Maximal interval enfants',

        # Keys
        Contact_id               Int,
        Categorie_id             Int,
        Unite_id                 Int,
        PRIMARY KEY (id),

        # Constaints
        CHECK(prixUnitaire > 0.00)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Emplacement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Emplacement  (
        id Int NOT NULL,
        nom Varchar(50),

        # Keys
        parent_id Int NOT NULL
        COMMENT 'Recursive emplacement',
        PRIMARY KEY (id, parent_id)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Compatibilité
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Compatibilite  (
        id                   Int NOT NULL,
        Modele_de_voiture_id Int NOT NULL,
        PRIMARY KEY (id, Modele_de_voiture_id)
) ENGINE=InnoDB;
