#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Bon de commande
#------------------------------------------------------------

CREATE TABLE Bon_de_commande(
        id           int (11) Auto_increment  NOT NULL ,
        dateCreation Date ,
        dateAchat    Date ,
        remise       Float ,
        id_Contact   Int ,
        id_Litige    Int ,
        id_Contact_1 Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Lot
#------------------------------------------------------------

CREATE TABLE Lot(
        id                 int (11) Auto_increment  NOT NULL ,
        numeroFournisseur  Varchar (25) ,
        quantite           Varchar (25) ,
        unite              Varchar (25) ,
        id_Modele_de_piece Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Modèle de pièce
#------------------------------------------------------------

CREATE TABLE Modele_de_piece(
        id                       int (11) Auto_increment  NOT NULL ,
        nom                      Varchar (50),
        designation              Varchar (120),
        marque                   Varchar (50), # Nouvelle table ?
        prixUnitaire             DECIMAL(15, 2),
        unite                    Varchar (25), # Nouvelle table ?
        categorie_id             Int,
        restriction              Varchar (2500), # Commentaire
        compatibiliteApplication Varchar (2500), # Commentaire
        commentaire              Varchar (2500),
        fichePdf                 Varchar (250),
        referanceConstructor     Varchar (25),
        lft                      Int, # Minimal internal
        rgt                      Int, # Maximal interval
        Contact_id               Int,
        PRIMARY KEY (id )
)ENGINE=MySAM;


#------------------------------------------------------------
# Table: Litige
#------------------------------------------------------------

CREATE TABLE Litige(
        id                 int (11) Auto_increment  NOT NULL ,
        dateLitige         Date ,
        commentaire        Varchar (25) ,
        id_Bon_de_commande Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Emplacement
#------------------------------------------------------------

CREATE TABLE Emplacement(
        id  int (11) Auto_increment  NOT NULL ,
        nom int (11) Auto_increment  ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Client
#------------------------------------------------------------

CREATE TABLE Client(
        id Int NOT NULL ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Voiture client
#------------------------------------------------------------

CREATE TABLE Voiture_client(
        id                    int (11) Auto_increment  NOT NULL ,
        imatriculation        Varchar (25) ,
        dateMiseEnCirculation Varchar (25) ,
        id_Contact            Int ,
        id_Modele_de_voiture  Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Fournisseur
#------------------------------------------------------------

CREATE TABLE Fournisseur(
        id Int NOT NULL ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Ligne de commande
#------------------------------------------------------------

CREATE TABLE Ligne_de_commande(
        id                 int (11) Auto_increment  NOT NULL ,
        prixUnitaire       Float ,
        quantite_commandee Int ,
        quantite_livree    Int ,
        id_Bon_de_commande Int ,
        id_Modele_de_piece Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Contact
#------------------------------------------------------------

CREATE TABLE Contact(
        id          int (11) Auto_increment  NOT NULL ,
        nom         Varchar (25) ,
        prenom      Varchar (25) ,
        sexe        Varchar (25) ,
        dateNaiss   Date ,
        adresse     Varchar (25) ,
        ville       Varchar (25) ,
        code_postal Varchar (25) ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Entreprise
#------------------------------------------------------------

CREATE TABLE Entreprise(
        id            int (11) Auto_increment  NOT NULL ,
        raisonSociale Varchar (25) ,
        siret         Varchar (25) ,
        siegeSocial   Varchar (25) ,
        codePostal    Varchar (25) ,
        ville         Varchar (25) ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Fiche salarié
#------------------------------------------------------------

CREATE TABLE Fiche_salarie(
        id           int (11) Auto_increment  NOT NULL ,
        dateEmbauche Date ,
        service      Varchar (25) ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Modèle de voiture
#------------------------------------------------------------

CREATE TABLE Modele_de_voiture(
        id               int (11) Auto_increment  NOT NULL ,
        marque           Varchar (25) ,
        modele           Varchar (25) ,
        type             Varchar (25) ,
        annee            Date ,
        motorisation     Varchar (25) ,
        carburantEnergie Varchar (25) ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Lot_Emplacement
#------------------------------------------------------------

CREATE TABLE Lot_Emplacement(
        id             Int NOT NULL ,
        id_Emplacement Int NOT NULL ,
        PRIMARY KEY (id ,id_Emplacement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Contact_Fiche salarié_Entreprise
#------------------------------------------------------------

CREATE TABLE Contact_Fiche_salarie_Entreprise(
        id               Int NOT NULL ,
        id_Contact       Int NOT NULL ,
        id_Fiche_salarie Int NOT NULL ,
        PRIMARY KEY (id ,id_Contact ,id_Fiche_salarie )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Compatibilité
#------------------------------------------------------------

CREATE TABLE Compatibilite(
        id                   Int NOT NULL ,
        id_Modele_de_voiture Int NOT NULL ,
        PRIMARY KEY (id ,id_Modele_de_voiture )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Dependre
#------------------------------------------------------------

CREATE TABLE Dependre(
        id                 Int NOT NULL ,
        id_Modele_de_piece Int NOT NULL ,
        PRIMARY KEY (id ,id_Modele_de_piece )
)ENGINE=InnoDB;

ALTER TABLE Bon_de_commande ADD CONSTRAINT FK_Bon_de_commande_id_Contact FOREIGN KEY (id_Contact) REFERENCES Contact(id);
ALTER TABLE Bon_de_commande ADD CONSTRAINT FK_Bon_de_commande_id_Litige FOREIGN KEY (id_Litige) REFERENCES Litige(id);
ALTER TABLE Bon_de_commande ADD CONSTRAINT FK_Bon_de_commande_id_Contact_1 FOREIGN KEY (id_Contact_1) REFERENCES Contact(id);
ALTER TABLE Lot ADD CONSTRAINT FK_Lot_id_Modele_de_piece FOREIGN KEY (id_Modele_de_piece) REFERENCES Modele_de_piece(id);
ALTER TABLE Modele_de_piece ADD CONSTRAINT FK_Modele_de_piece_id_Contact FOREIGN KEY (id_Contact) REFERENCES Contact(id);
ALTER TABLE Litige ADD CONSTRAINT FK_Litige_id_Bon_de_commande FOREIGN KEY (id_Bon_de_commande) REFERENCES Bon_de_commande(id);
ALTER TABLE Client ADD CONSTRAINT FK_Client_id FOREIGN KEY (id) REFERENCES Contact(id);
ALTER TABLE Voiture_client ADD CONSTRAINT FK_Voiture_client_id_Contact FOREIGN KEY (id_Contact) REFERENCES Contact(id);
ALTER TABLE Voiture_client ADD CONSTRAINT FK_Voiture_client_id_Modele_de_voiture FOREIGN KEY (id_Modele_de_voiture) REFERENCES Modele_de_voiture(id);
ALTER TABLE Fournisseur ADD CONSTRAINT FK_Fournisseur_id FOREIGN KEY (id) REFERENCES Contact(id);
ALTER TABLE Ligne_de_commande ADD CONSTRAINT FK_Ligne_de_commande_id_Bon_de_commande FOREIGN KEY (id_Bon_de_commande) REFERENCES Bon_de_commande(id);
ALTER TABLE Ligne_de_commande ADD CONSTRAINT FK_Ligne_de_commande_id_Modele_de_piece FOREIGN KEY (id_Modele_de_piece) REFERENCES Modele_de_piece(id);
ALTER TABLE Lot_Emplacement ADD CONSTRAINT FK_Lot_Emplacement_id FOREIGN KEY (id) REFERENCES Lot(id);
ALTER TABLE Lot_Emplacement ADD CONSTRAINT FK_Lot_Emplacement_id_Emplacement FOREIGN KEY (id_Emplacement) REFERENCES Emplacement(id);
ALTER TABLE Contact_Fiche salarié_Entreprise ADD CONSTRAINT FK_Contact_Fiche_salarie_Entreprise_id FOREIGN KEY (id) REFERENCES Entreprise(id);
ALTER TABLE Contact_Fiche salarié_Entreprise ADD CONSTRAINT FK_Contact_Fiche_salarie_Entreprise_id_Contact FOREIGN KEY (id_Contact) REFERENCES Contact(id);
ALTER TABLE Contact_Fiche salarié_Entreprise ADD CONSTRAINT FK_Contact_Fiche_salarie_Entreprise_id_Fiche_salarie FOREIGN KEY (id_Fiche_salarie) REFERENCES Fiche_salarie(id);
ALTER TABLE Compatibilite ADD CONSTRAINT FK_Compatibilite_id FOREIGN KEY (id) REFERENCES Modele_de_piece(id);
ALTER TABLE Compatibilite ADD CONSTRAINT FK_Compatibilite_id_Modele_de_voiture FOREIGN KEY (id_Modele_de_voiture) REFERENCES Modele_de_voiture(id);
ALTER TABLE Dependre ADD CONSTRAINT FK_Dependre_id FOREIGN KEY (id) REFERENCES Modele_de_piece(id);
ALTER TABLE Dependre ADD CONSTRAINT FK_Dependre_id_Modele_de_piece FOREIGN KEY (id_Modele_de_piece) REFERENCES Modele_de_piece(id);
