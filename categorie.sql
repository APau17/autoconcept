#------------------------------------------------------------
# Table: Categorie
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Categorie (
        id Int (11) Auto_increment NOT NULL,

        nom Varchar (50) NOT NULL,

        lft Int (11) ,

        rgt Int (11) ,

        # Keys
        Modele_de_piece_id Int ,
        PRIMARY KEY (id)
) ENGINE=InnoDB;