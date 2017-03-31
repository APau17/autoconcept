#------------------------------------------------------------
# Table: Categorie Piece
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Categorie_piece (
        id Int (11) Auto_increment NOT NULL,

        nom Varchar (50) NOT NULL,

        lft Int (11) ,

        rgt Int (11) ,

        # Keys
        Modele_de_piece_id Int ,
        PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Categorie_commande (
        id Int (11) Auto_increment NOT NULL,

        nom Varchar (50) NOT NULL,

        lft Int (11) ,

        rgt Int (11) ,

        # Keys
        Ligne_de_commande_id Int ,
        PRIMARY KEY (id)
) ENGINE=InnoDB;