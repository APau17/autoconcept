#------------------------------------------------------------
# Table: Bon de commande
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Bon_de_commande (
        id int (11) Auto_increment NOT NULL,

        dateCreation Date
        COMMENT 'Si non null, alors la commande est engage',

        dateAchat    Date
        COMMENT 'Si non null, alors la commande peut etre livree',

        dateLivraison    Date
        COMMENT 'Si non null, alors la commande est finalisee',

        remise       DECIMAL (3, 2)
        COMMENT 'Pourcentage'

        # Keys
        Contact_Fournisseur_id Int,
        Contact_Client_id Int,
        Litige_id Int,
        PRIMARY KEY (id )

        # Constraints
        CHECK(remise > 0 AND remise < 1),
) ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Litige
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Litige  (
        id                 int (11) Auto_increment  NOT NULL ,
        dateLitige         Date ,
        commentaire        Varchar (25) ,
        Bon_de_commande_id Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Emplacement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Emplacement  (
        id  int (11) Auto_increment  NOT NULL ,
        nom int (11) Auto_increment  ,
        parent_id int(11),
        PRIMARY KEY (id)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Ligne de commande
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Ligne_de_commande  (
        id                 int (11) Auto_increment  NOT NULL ,
        prixUnitaire       Float ,
        quantite_commandee Int ,
        quantite_livree    Int ,
        Bon_de_commande_id Int ,
        id_Bon_de_commande Int ,
        Modele_de_piece_id Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


