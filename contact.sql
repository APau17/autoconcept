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
# Table: Contact
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Contact  (
        id          int (11) Auto_increment  NOT NULL,
        nom         Varchar (50) ,
        prenom      Varchar (50) ,
        sexe        Int,
        dateNaiss   Date ,
        adresse     Varchar (50) ,
        ville       Varchar (50) ,
        code_postal Varchar (9) ,
        PRIMARY KEY (id)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Entreprise
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Entreprise  (
        id            int (11) Auto_increment  NOT NULL ,
        raisonSociale Varchar (50) ,
        siret         Varchar (50) ,
        siegeSocial   Varchar (50) ,
        codePostal    Varchar (9) ,
        ville         Varchar (50) ,
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
        marque           Varchar (50) ,
        modele           Varchar (25) ,
        classe           Varchar (25) ,
        annee            Date ,
        motorisation     Varchar (25) ,
        carburantEnergie Varchar (25) ,
        PRIMARY KEY (id)
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
