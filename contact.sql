#------------------------------------------------------------
# Table: Client
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Client  (
        id Int NOT NULL ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Voiture client
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Voiture_client  (
        id                    int (11) Auto_increment  NOT NULL ,
        imatriculation        Varchar (25) ,
        dateMiseEnCirculation Varchar (25) ,
        Contact_id            Int ,
        Modele_de_voiture_id  Int ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Fournisseur
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Fournisseur  (
        id Int NOT NULL ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: Contact
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Contact  (
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

CREATE TABLE IF NOT EXISTS Entreprise  (
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

CREATE TABLE IF NOT EXISTS Fiche_salarie  (
        id           int (11) Auto_increment  NOT NULL ,
        dateEmbauche Date ,
        service      Varchar (25) ,
        PRIMARY KEY (id )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Modèle de voiture
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_voiture  (
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
# Table: Contact_Fiche salarié_Entreprise
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Contact_Fiche_salarie_Entreprise  (
        id               Int NOT NULL ,
        Contact_id       Int NOT NULL ,
        Fiche_salarie_id Int NOT NULL ,
        PRIMARY KEY (id ,Contact_id ,Fiche_salarie_id )
)ENGINE=InnoDB;
