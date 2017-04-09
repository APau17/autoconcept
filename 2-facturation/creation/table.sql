#------------------------------------------------------------
# Table: Bon de commande
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Bon_de_commande (
        id int (11) Auto_increment NOT NULL,

        dateCreation Date
        COMMENT 'Si non null, alors la commande est engagee',

        dateAchat    Date
        COMMENT 'Si non null, alors la commande peut etre livree',

        dateLivraison    Date
        COMMENT 'Si non null, alors la commande est finalisee',

        remise       DECIMAL (3, 2)
        COMMENT 'Pourcentage',

        # Keys
        Contact_Fournisseur_id Int,
        Contact_Client_id Int,
        Litige_id Int,
        PRIMARY KEY (id),

        # Constraints
        CHECK(remise > 0 AND remise < 1)
) ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Litige
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Litige  (
        id                 int (11) Auto_increment  NOT NULL,

        dateLitige         Date,

        commentaire        Text
        COMMENT 'Commentaire libre',

        # Keys
        Bon_de_commande_id Int,
        PRIMARY KEY (id)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Ligne de commande
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Ligne_de_commande  (
        id                 int (11) Auto_increment  NOT NULL,

        prixUnitaire       DECIMAL (15, 2),

        quantiteCommandee Int,
        quantiteLivree    Int,

        # Keys
        Bon_de_commande_id Int,
        Modele_de_piece_id Int,
        PRIMARY KEY (id)
)ENGINE=InnoDB;
