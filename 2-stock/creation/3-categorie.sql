#------------------------------------------------------------
# Table: Categorie_Piece
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
