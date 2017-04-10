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
        COMMENT 'Commentaire libre'

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
