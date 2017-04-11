#------------------------------------------------------------
# Table: Parametre
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Parametre (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        clef Varchar(50) NOT NULL,
        valeur Varchar (50) NOT NULL,
        commentaire Text
);

INSERT INTO `Parametre` (clef, valeur, commentaire) VALUES ('entreprise', '1', 'Clef primaire de \'entreprise autoconcept');
