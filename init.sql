DROP DATABASE IF EXISTS autoconcept;
CREATE DATABASE IF NOT EXISTS autoconcept;
USE autoconcept;
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
#------------------------------------------------------------
# Table: Adresse
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Adresse (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        adresse Varchar(100) NOT NULL,
        ville Varchar (50) NOT NULL,
        codePostal Varchar (6) NOT NULL,

		#Constraints
        CONSTRAINT discriminant UNIQUE(adresse, ville, codePostal)
        COMMENT "L'alliance d'une adresse, d'une ville et d'un code postal doit etre unique"
);

#------------------------------------------------------------
# Table: Entreprise
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Entreprise (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        raisonSociale Varchar (50) NOT NULL,

        siret         Varchar (14) NOT NULL UNIQUE,

        logo Text
        COMMENT 'Uri vers le logo',

        parent_id Int
        COMMENT 'Maison mère',

        # FK
        Adresse_id Int NOT NULL
        COMMENT 'Adresse du siege sociale',
        FOREIGN KEY (Adresse_id) REFERENCES Adresse(id)
);

#------------------------------------------------------------
# Table: Contact
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Contact (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (50) NOT NULL,
        prenom Varchar (50) NOT NULL,

        sexe Boolean
        COMMENT '0 pour les hommes. 1 pour les femmes',

        dateNaiss Date
        COMMENT 'Date de naissance',

		courriel Varchar (50),

        telephone Varchar(10)
        COMMENT 'Format avec dix chiffres sans delimiteur',

        #Constraints
        CONSTRAINT discriminant UNIQUE(nom, prenom, dateNaiss)
        COMMENT "L'alliance d'un nom, prenom et date de naissance doit etre unique"
);

#------------------------------------------------------------
# Table: Droit
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Droit (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar(50) UNIQUE,

        facturable Boolean NOT NULL
        DEFAULT 1,

        livrable Boolean NOT NULL
        DEFAULT 1
);

#------------------------------------------------------------
# Table: Partenaire
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Partenaire (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        Contact_id Int NOT NULL,
        Entreprise_id Int,
        Droit_id Int NOT NULL,

        #Constraints
        CONSTRAINT discriminant UNIQUE(Contact_id, Entreprise_id, Droit_id),

        # FK
        FOREIGN KEY (Entreprise_id) REFERENCES Contact(id),
        FOREIGN KEY (Contact_id) REFERENCES Contact(id),
        FOREIGN KEY (Droit_id) REFERENCES Droit(id)
);

#------------------------------------------------------------
# Table: Modèle_de_voiture
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_voiture (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        modele Varchar (50),
        classe Varchar (50),
        annee Date,
        motorisation Varchar (50),
        carburantEnergie Varchar (50),

        # FK
        Entreprise_id Int
        COMMENT 'Marque',
        FOREIGN KEY (Entreprise_id) REFERENCES Entreprise(id)
);

#------------------------------------------------------------
# Table: Voiture_client
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Voiture_client (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        immatriculation Varchar (25),
        dateMiseEnCirculation Date,

        dateCreation DATETIME DEFAULT CURRENT_TIMESTAMP,
        dateModification DATETIME DEFAULT CURRENT_TIMESTAMP,

        # Index
        INDEX immatriculation_index (immatriculation),

        # Keys
        parent_id Int
        COMMENT "Si null, proprietaire actuelle. Sinon nouveau proprietaire.",

        # FK
        Partenaire_id Int NOT NULL,
        Modele_de_voiture_id Int,
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id),
        FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id)
);

#------------------------------------------------------------
# Table: Fiche_salarié
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Fiche_salarie  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateEmbauche Date,
        service Varchar (25),
		nomUtilisateurSql Varchar (50),

        #FK
        Partenaire_id int NOT NULL,
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id)
);

#------------------------------------------------------------
# Table: Partenaire_Adresse
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Partenaire_Adresse  (
        Adresse_id Int NOT NULL,
        Partenaire_id Int NOT NULL,

        dateCreation DATETIME DEFAULT CURRENT_TIMESTAMP,
        dateModification DATETIME DEFAULT CURRENT_TIMESTAMP,

        FOREIGN KEY (Adresse_id) REFERENCES Adresse(id),
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id)
);
INSERT INTO Droit(nom, facturable, livrable) VALUES ("Particulier", 1, 0);
INSERT INTO Droit(nom, facturable, livrable) VALUES ("Chef d'entreprise", 1, 1);
INSERT INTO Droit(nom, facturable, livrable) VALUES ("Comptable", 1, 0);
INSERT INTO Droit(nom, facturable, livrable) VALUES ("Commercial", 0, 1);
INSERT INTO Droit(nom, facturable, livrable) VALUES ("Technicien", 0, 1);
INSERT INTO Droit(nom, facturable, livrable) VALUES ("Salarié", 0, 1);
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `nouveau_proprietaire`(IN `parent` INT, IN `imma` TEXT)
    NO SQL
UPDATE Voiture_client SET parent_id=parent WHERE  immatriculation=imma AND parent_id IS NULL AND id!=parent$$
DELIMITER ;
CREATE VIEW Liste_employees_v AS SELECT nom,prenom,dateNaiss,courriel,telephone,Entreprise_id FROM Partenaire INNER JOIN Contact ON Contact.id=Partenaire.Contact_id;
CREATE VIEW Liste_employees_autoconcept_v AS SELECT nom,prenom,dateNaiss,courriel,telephone FROM Partenaire INNER JOIN Parametre v ON v.clef="Entreprise" INNER JOIN Partenaire p ON p.Entreprise_id=v.valeur INNER JOIN Contact ON Contact.id=p.Contact_id;
CREATE VIEW Liste_employees_autoconcept_filiale_v AS SELECT nom,prenom,dateNaiss,courriel,telephone FROM Partenaire INNER JOIN Parametre v ON v.clef = "Entreprise" INNER JOIN Entreprise ON Entreprise.parent_id=v.valeur INNER JOIN Partenaire p ON Partenaire.Entreprise_id=Entreprise.id INNER JOIN Contact ON Contact.id = p.Contact_id;
#------------------------------------------------------------
# Table: Unite
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Unite  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (25) NOT NULL UNIQUE,

        ratio Float
        COMMENT 'Ratio entre les unites',

        # Keys
        Unite_base_id Int
);
#------------------------------------------------------------
# Table: Modèle_de_pièce
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Modele_de_piece  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar (50) NOT NULL UNIQUE
        COMMENT '',

        designation Varchar (120)
        COMMENT '',

        restriction Text
        COMMENT 'Commentaire libre',

        compatibiliteApplication Text
        COMMENT 'Commentaire libre',

        commentaire Text
        COMMENT 'Commentaire libre',

        fichePdf Text
        COMMENT 'URL vers la documentation',

        referenceConstructeur Text
        COMMENT 'Le format est libre',

        # Keys
        Unite_id Int,
        FOREIGN KEY (Unite_id) REFERENCES Unite(id)
);

#------------------------------------------------------------
# Table: Dépendance
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Dependance  (
        Modele_de_piece_id Int NOT NULL,
        Modele_de_piece_id_dependre Int NOT NULL,
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id),
        FOREIGN KEY (Modele_de_piece_id_dependre) REFERENCES Modele_de_piece(id)
) ;

#------------------------------------------------------------
# Table: Emplacement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Emplacement  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        nom Varchar(50),
        virtuel Boolean,

        # Keys
        parent_id Int
        COMMENT 'Recursive emplacement'
);

#------------------------------------------------------------
# Table: Lot
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Lot  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        numeroFournisseur Varchar(50)
        UNIQUE,

        quantite Int NOT NULL
        COMMENT 'Ne peut pas etre inferieur a zero',

        # Keys
        Emplacement_id Int NOT NULL,
        Modele_de_piece_id Int NOT NULL,
        Unite_id Int NOT NULL,
        FOREIGN KEY (Emplacement_id) REFERENCES Emplacement(id),
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id),
        FOREIGN KEY (Unite_id) REFERENCES Unite(id)
) ;

#------------------------------------------------------------
# Table: Mouvement
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Mouvement  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateMouvement Date,

        # Keys
        parent_id Int NOT NULL
        COMMENT 'Nouvelle emplacement du lot',

        Emplacement_id Int NOT NULL,
        Lot_id Int NOT NULL,
        Partenaire_id Int NOT NULL,

        FOREIGN KEY (Emplacement_id) REFERENCES Emplacement(id),
        FOREIGN KEY (Lot_id) REFERENCES Lot(id),
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id)
) ;


#------------------------------------------------------------
# Table: Compatibilité
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Compatibilite  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        # Keys
        Modele_de_voiture_id Int NOT NULL,
        Modele_de_piece_id Int NOT NULL,
        FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id),
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id)
) ;
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
INSERT INTO Categorie_piece(id, nom, lft, rgt) VALUES (1, "Categorie", 1, 7);
INSERT INTO Categorie_piece(id, nom, lft, rgt) VALUES (2, "Carroserie", 2, 3);
INSERT INTO Categorie_piece(id, nom, lft, rgt) VALUES (3, "Habitacle", 3, 4);
INSERT INTO Categorie_piece(id, nom, lft, rgt) VALUES (4, "Moteur & dependances", 4, 5);
INSERT INTO Categorie_piece(id, nom, lft, rgt) VALUES (5, "Consommable", 5, 6);
INSERT INTO Categorie_piece(id, nom, lft, rgt) VALUES (6, "Accesoires & entretiens", 6, 7);
#INSERT INTO Compatibilite(id, Modele_de_voiture_id ) VALUES (1, 1);
#INSERT INTO Compatibilite(id, Modele_de_voiture_id ) VALUES (2, 2);
#INSERT INTO Compatibilite(id, Modele_de_voiture_id ) VALUES (3, 3);
#INSERT INTO Compatibilite(id, Modele_de_voiture_id ) VALUES (4, 4);
#INSERT INTO Compatibilite(id, Modele_de_voiture_id ) VALUES (5, 5);
#INSERT INTO Compatibilite(id, Modele_de_voiture_id ) VALUES (6, 6);
INSERT INTO Emplacement(id, nom, parent_id ) VALUES (1, "Batiment", NULL);
INSERT INTO Emplacement(id, nom, parent_id ) VALUES (2, "Armoire", 1);
INSERT INTO Emplacement(id, nom, parent_id ) VALUES (3, "Etagere", 2);
INSERT INTO Emplacement(id, nom, parent_id ) VALUES (4, "Batiment", NULL);
INSERT INTO Emplacement(id, nom, parent_id ) VALUES (5, "Armoire", 1);
INSERT INTO Emplacement(id, nom, parent_id ) VALUES (6, "Etagere", 2);
INSERT INTO Unite(id, nom, ratio) VALUES (1, "Unite", 1);
INSERT INTO Unite(id, nom, ratio) VALUES (2, "g", 1);
INSERT INTO Unite(id, nom, ratio, Unite_base_id) VALUES (3, "kg", 1000, 2);
INSERT INTO Unite(id, nom, ratio, Unite_base_id) VALUES (4, "mg", 0.001, 2);
INSERT INTO Unite(id, nom, ratio) VALUES (5, "m", 1);
INSERT INTO Unite(id, nom, ratio, Unite_base_id) VALUES (6, "mm", 0.001, 5);
#------------------------------------------------------------
# Table: Prix
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Prix (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        prixUnitaire DECIMAL(15, 2) NOT NULL
        COMMENT 'En euros. Il ne peut pas etre inferieur a zero',

        marge FLOAT NOT NULL,

        dateCreation DATETIME DEFAULT CURRENT_TIMESTAMP,
        dateModification DATETIME DEFAULT CURRENT_TIMESTAMP,

        # Keys
        Modele_de_piece_id Int NOT NULL,
        Partenaire_id Int NOT NULL,
        Unite_id Int NOT NULL,
        FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id),
        FOREIGN KEY (Partenaire_id) REFERENCES Partenaire(id),
        FOREIGN KEY (Unite_id) REFERENCES Unite(id)
);

#------------------------------------------------------------
# Table: Bon_de_commande
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
        Partenaire_Client_id_Facturation Int,
        Partenaire_Client_id_Livraison Int,
        FOREIGN KEY (Partenaire_Fournisseur_id) REFERENCES Partenaire(id),
        FOREIGN KEY (Partenaire_Client_id_Facturation) REFERENCES Partenaire(id),
        FOREIGN KEY (Partenaire_Client_id_Livraison) REFERENCES Partenaire(id)
);

#------------------------------------------------------------
# Table: Litige
#------------------------------------------------------------

CREATE TABLE IF NOT EXISTS Litige  (
        id Int Auto_increment PRIMARY KEY
        COMMENT 'Clef primaire',

        dateLitige Date,

        commentaire Text
        COMMENT 'Commentaire libre',

        # Keys
        Bon_de_commande_id_origine Int
        COMMENT 'Bon de commmande provoquant le litige',

        Bon_de_commande_id_resolution Int
        COMMENT 'Bon de commmande qui résoud le litige',

        FOREIGN KEY (Bon_de_commande_id_origine) REFERENCES Bon_de_commande(id),
        FOREIGN KEY (Bon_de_commande_id_resolution) REFERENCES Bon_de_commande(id)
);

#------------------------------------------------------------
# Table: Ligne_de_commande
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
        Bon_de_commande_id Int NOT NULL,
        Prix_id Int NOT NULL,
        FOREIGN KEY (Bon_de_commande_id) REFERENCES Bon_de_commande(id),
        FOREIGN KEY (Prix_id) REFERENCES Prix(id)
);
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (1, "147 Rue Du Sommerard", "Angers", "33250");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (2, "64 Quai de Montmorency", "Caen", "76144");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (3, "180 Quai d'Alésia", "Toulouse", "81223");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (4, "9579 Quai de Provence", "Niort", "42029");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (5, "27 Place des Grands Augustins", "Toulon", "84773");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (6, "1 Rue Charlemagne", "Amiens", "34724");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (7, "105 Avenue de la Huchette", "Lorient", "86133");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (8, "201 Boulevard Mouffetard", "Quimper", "45474");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (9, "44 Place de Provence", "Amiens", "29431");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (10, "27 Passage des Francs-Bourgeois", "Courbevoie", "69877");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (11, "5468 Quai de Vaugirard", "Reims", "14978");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (12, "7 Boulevard Monsieur-le-Prince", "Saint-Nazaire", "74273");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (13, "63 Avenue Oberkampf", "Dunkerque14", "23672");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (14, "25 Rue des Saussaies", "Asnières-sur-Seine", "30986");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (15, "8 Boulevard Pastourelle", "Metz", "97827");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (16, "2 Rue Bonaparte", "Toulon", "95760");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (17, "5 Place Joubert", "Courbevoie", "82259");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (18, "986 Impasse Oberkampf", "Pau", "76428");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (19, "90 Impasse Montorgueil", "Pau", "24122");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (20, "8 Impasse de Solférino", "Courbevoie", "70328");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (21, "82 Quai du Chat-qui-Pêche", "Limoges", "91392");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (22, "4 Impasse Dauphine", "Calais", "75275");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (23, "52 Quai de Provence", "Besançon", "29509");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (24, "7602 Place de la Victoire", "Cergy", "95788");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (25, "4 Place Du Sommerard", "Paris", "60750");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (26, "73 Avenue des Rosiers", "Amiens", "24538");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (27, "98 Rue d'Argenteuil", "Mulhouse", "76881");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (28, "1292 Avenue de Paris", "Hyères", "84448");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (29, "613 Quai de Richelieu", "Dijon", "46695");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (30, "36 Rue des Lombards", "Dijon", "50816");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (31, "37 Allée, Voie Saint-Séverin", "Valence", "63274");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (32, "6 Boulevard Saint-Jacques", "Montreuil", "79646");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (33, "40 Impasse Oberkampf", "Angers", "16225");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (34, "8 Allée, Voie Bonaparte", "La Seyne-sur-Mer", "61831");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (35, "3 Place d'Assas", "Montreuil", "61575");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (36, "71 Place Royale", "Asnières-sur-Seine", "39036");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (37, "6 Rue des Grands Augustins", "Besançon", "74200");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (38, "665 Quai de Nesle", "Avignon", "70321");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (39, "5 Boulevard Saint-Jacques", "Le Havre", "53254");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (40, "8 Impasse Pastourelle", "Toulouse", "98277");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (41, "809 Place Monsieur-le-Prince", "Troyes", "67264");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (42, "65 Passage des Francs-Bourgeois", "Antibes", "94404");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (43, "8377 Quai Saint-Honoré", "Nanterre", "73487");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (44, "27 Place Monsieur-le-Prince", "Niort", "10697");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (45, "7033 Avenue de Montmorency", "Bourges", "27537");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (46, "48 Quai du Faubourg-Saint-Denis", "Saint-Étienne", "46456");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (47, "8 Passage de l'Abbaye", "Créteil", "24403");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (48, "2290 Allée, Voie Pastourelle", "Sarcelles", "16616");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (49, "60 Quai de la Harpe", "Toulon", "13174");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (50, "1845 Impasse de Presbourg", "Rueil-Malmaison", "73165");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (51, "5141 Rue Du Sommerard", "Pessac", "81344");
INSERT INTO Adresse (id, adresse, ville, codePostal) VALUES (52, "420 Quai Marcadet", "Marseille", "88866");
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (1, "CSEPEL AUTOGYAR", "40833760636795", "https://robohash.org/occaecatiipsumvoluptatem.png?size=300x300&set=set1", 1);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (2, "P. BARTHAU STAHLBAU", "21130232875558", "https://robohash.org/quisquiavoluptas.png?size=300x300&set=set1", 2);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (3, "SICHUAN LESHAN BUS WORKS", "29490352690881", "https://robohash.org/namautvero.png?size=300x300&set=set1", 3);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (4, "YULON MOTOR CO., LTD.", "25195782637456", "https://robohash.org/voluptatemmaximeut.png?size=300x300&set=set1", 4);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (5, "LAND ROVER GROUP LTD", "54063278760715", "https://robohash.org/aspernaturinventorevel.png?size=300x300&set=set1", 5);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (6, "HONDA MANUFACTURING OF ALABAMA", "29713148313576", "https://robohash.org/quoassumendaquaerat.png?size=300x300&set=set1", 6);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (7, "SOMACOA (STE. MALGACHE DE", "80273602605708", "https://robohash.org/dolorumaperiamat.png?size=300x300&set=set1", 7);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (8, "ZAKLAD BUDOWY I REMONTOW NACZEP WIE", "21927929663720", "https://robohash.org/autmodinihil.png?size=300x300&set=set1", 8);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (9, "P. BARTHAU STAHLBAU", "92943961243540", "https://robohash.org/quiautreprehenderit.png?size=300x300&set=set1", 9);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (10, "AJAX MANUFACTURING COMPANY, INC.", "63166055371658", "https://robohash.org/quisquamdoloremquepossimus.png?size=300x300&set=set1", 10);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (11, "SANOCKA FABRYKA AUTOBUSOW SFA", "91068811073547", "https://robohash.org/consequunturessedolor.png?size=300x300&set=set1", 11);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (12, "SOMACOA (STE. MALGACHE DE", "65495947550841", "https://robohash.org/totamquisquamincidunt.png?size=300x300&set=set1", 12);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (13, "AUTOMOTRIZ PEYCHA, S.A. DE C.V.", "23363249812879", "https://robohash.org/ameterrorrerum.png?size=300x300&set=set1", 13);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (14, "HERO HONDA MOTORS LTD", "46576640074307", "https://robohash.org/possimusconsecteturnam.png?size=300x300&set=set1", 14);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (15, "DAIMLERCHRYSLER CORPORATION", "79626263403154", "https://robohash.org/numquamrepudiandaererum.png?size=300x300&set=set1", 15);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (16, "SSANGYONG MOTOR COMPANY", "34673825835504", "https://robohash.org/beataedoloribusaut.png?size=300x300&set=set1", 16);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (17, "YULON MOTOR CO., LTD.", "40348985058578", "https://robohash.org/dignissimostemporaofficia.png?size=300x300&set=set1", 17);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (18, "P. BARTHAU STAHLBAU", "55623076461889", "https://robohash.org/aliquamnobisoptio.png?size=300x300&set=set1", 18);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (19, "AUTOMOTRIZ PEYCHA, S.A. DE C.V.", "77061101838851", "https://robohash.org/sapientequibusdamimpedit.png?size=300x300&set=set1", 19);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (20, "SSANGYONG MOTOR COMPANY", "35880328115342", "https://robohash.org/estvoluptatemdeleniti.png?size=300x300&set=set1", 20);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (21, "CHYONG HORNG ENTERPRISE CO., LTD.", "54257997031201", "https://robohash.org/iustoexercitationema.png?size=300x300&set=set1", 21);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (22, "FIAT DIESEL BRASIL S/A", "63138363617237", "https://robohash.org/quietest.png?size=300x300&set=set1", 22);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (23, "AUTOMOTRIZ PEYCHA, S.A. DE C.V.", "87221778311065", "https://robohash.org/autemdoloremqueharum.png?size=300x300&set=set1", 23);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (24, "BAY EQUIPMENT & REPAIR", "51671095063210", "https://robohash.org/rationeofficiisexplicabo.png?size=300x300&set=set1", 24);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (25, "AMERICAN TRANSPORTATION CORPORATION", "92530925218099", "https://robohash.org/estminusodio.png?size=300x300&set=set1", 25);
INSERT INTO Entreprise (id, raisonSociale, siret, logo, Adresse_id) VALUES (26, "Legrand et Fernandez", "20155188623629", "https://robohash.org/omnisquibusdamanimi.png?size=300x300&set=set1", 27);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (1, "A5", "Compacte", "1991-11-26", "8 cylindres", "Essence Hybrid", 1);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (2, "Riveria", "sportive", "2006-10-15", "8 cylindres", "Gaz naturel compressé", 2);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (3, "Malibu", "Compacte", "1973-08-31", "8 cylindres", "Diesel", 1);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (4, "X5", "Citadine", "2004-07-12", "6 cylindres", "E-85/Essence", 1);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (5, "Juke", "Citadine", "1981-01-19", "8 cylindres", "E-85/Essence", 2);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (6, "X1", "Citadine", "2008-12-09", "4 cylindres", "Gaz naturel compressé", 3);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (7, "Focus", "sportive", "2001-10-09", "6 cylindres", "Diesel", 3);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (8, "M5", "sportive", "1974-10-24", "4 cylindres", "Électrique", 2);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (9, "Ram", "break", "1986-09-01", "6 cylindres", "Diesel", 2);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (10, "CR-V", "sportive", "1977-12-17", "6 cylindres", "Diesel", 3);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (11, "Silverado", "sportive", "1978-10-02", "6 cylindres", "E-85/Essence", 4);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (12, "Challenger", "sportive", "1980-10-09", "4 cylindres", "Diesel", 6);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (13, "A5", "sportive", "1985-07-21", "4 cylindres", "Essence", 1);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (14, "MKS", "break", "2009-04-27", "4 cylindres", "Essence", 1);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (15, "Odyssey", "Compacte", "1991-05-29", "8 cylindres", "Essence Hybrid", 2);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (16, "Riveria", "Citadine", "1990-05-12", "4 cylindres", "E-85/Essence", 10);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (17, "A8", "sportive", "1978-08-28", "8 cylindres", "Diesel", 17);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (18, "F150", "break", "1977-11-27", "6 cylindres", "Électrique", 9);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (19, "MKS", "Compacte", "1985-04-10", "4 cylindres", "Essence", 7);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (20, "Camry", "Citadine", "1996-05-09", "8 cylindres", "Essence Hybrid", 1);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (21, "Charger", "sportive", "2001-04-08", "4 cylindres", "Électrique", 3);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (22, "Regal", "Compacte", "1971-03-31", "8 cylindres", "Essence", 14);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (23, "A7", "break", "1973-12-10", "4 cylindres", "E-85/Essence", 13);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (24, "M5", "Citadine", "1992-08-20", "6 cylindres", "Essence Hybrid", 24);
INSERT INTO Modele_de_voiture (id, modele, classe, annee, motorisation, carburantEnergie, Entreprise_id) VALUES (25, "Enclave", "Citadine", "2007-10-05", "4 cylindres", "E-85/Essence", 3);
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (1, "Garcia", "Nathan", 1, "1980-10-25", "cicero.gutkowski@hauck.io", "0644176777");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (2, "Andre", "Océane", 0, "1980-06-02", "wilhelm_nikolaus@beer.biz", "0471249492");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (3, "Guerin", "Lena", 0, "1991-03-22", "florine@kuvalis.net", "0596686731");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (4, "Vincent", "Marie", 1, "2010-01-29", "bret.schowalter@parisian.biz", "0442619823");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (5, "Faure", "Justine", 0, "1974-09-07", "wilfrid@beervolkman.org", "0508710334");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (6, "Berger", "Louna", 0, "2005-02-28", "lelia@sanford.org", "0993829184");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (7, "Lecomte", "Enzo", 0, "2007-06-19", "bonnie@kuhn.co", "0578921356");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (8, "Paul", "Maëlle", 1, "1982-12-25", "terence.brekke@rippinwhite.name", "0372312189");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (9, "Laurent", "Maëlys", 1, "2011-08-22", "chris@lemke.io", "0744374086");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (10, "Le gall", "Mohamed", 1, "2002-01-27", "thea@lubowitz.info", "0302839994");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (11, "Leclerc", "Lisa", 1, "2003-03-12", "britney_conn@zboncak.net", "0248591166");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (12, "Gauthier", "Julien", 0, "2016-03-21", "stephania_johns@olson.net", "0868978346");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (13, "Lefebvre", "Lucie", 1, "1970-02-13", "cooper@senger.biz", "0657917398");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (14, "Durand", "Adam", 0, "2004-11-29", "jewell@vandervortlangworth.net", "0496731003");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (15, "Chevalier", "Sacha", 0, "1980-06-19", "coby@ebertbailey.biz", "0920654742");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (16, "Guillot", "Hugo", 0, "2017-03-26", "adelbert.pacocha@kohler.name", "0218912376");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (17, "Roy", "Mathilde", 0, "1975-10-31", "brooks_bradtke@kovacek.net", "0137581868");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (18, "Aubry", "Raphaël", 1, "1972-11-28", "alverta@adamswiza.biz", "0892654087");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (19, "Robin", "Lucie", 1, "1975-09-21", "micheal_hauck@ondrickazemlak.info", "0293233503");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (20, "Roy", "Charlotte", 0, "1992-08-22", "andy@fritsch.info", "0920314028");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (21, "Garnier", "Marie", 0, "1998-07-15", "lura@heathcote.biz", "0381948300");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (22, "Perrot", "Noémie", 0, "1986-01-28", "ephraim.runolfon@funk.org", "0868272275");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (23, "Picard", "Quentin", 1, "2014-11-11", "vernie.hermann@rogahnleffler.com", "0142512011");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (24, "Jacquet", "Victor", 0, "1983-05-02", "celia.champlin@adams.com", "0138446300");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (25, "Robert", "Clara", 1, "1989-08-28", "jovan@jaskolski.net", "0836708580");
INSERT INTO Contact (id, nom, prenom, sexe, dateNaiss, courriel, telephone) VALUES (26, "Muller", "Léo", 0, "1992-04-12", "derek_krajcik@crooks.io", "0986113544");
INSERT INTO Partenaire (id, Contact_id, Droit_id) VALUES (1, 1, 3);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (2, 2, 26, 2);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (3, 3, 26, 5);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (4, 4, 26, 5);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (5, 5, 26, 4);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (6, 6, 26, 2);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (7, 7, 26, 1);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (8, 8, 26, 5);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (9, 9, 26, 3);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (10, 10, 26, 5);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (11, 11, 26, 4);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (12, 12, 26, 3);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (13, 13, 26, 2);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (14, 14, 26, 2);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (15, 15, 26, 4);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (16, 16, 26, 4);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (17, 17, 26, 3);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (18, 18, 26, 4);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (19, 19, 26, 4);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (20, 20, 26, 2);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (21, 21, 26, 1);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (22, 22, 26, 5);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (23, 23, 26, 3);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (24, 24, 26, 5);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (25, 25, 26, 2);
INSERT INTO Partenaire (id, Contact_id, Entreprise_id, Droit_id) VALUES (26, 26, 26, 4);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (26, 1);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (28, 2);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (29, 3);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (30, 4);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (31, 5);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (32, 6);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (33, 7);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (34, 8);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (35, 9);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (36, 10);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (37, 11);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (38, 12);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (39, 13);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (40, 14);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (41, 15);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (42, 16);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (43, 17);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (44, 18);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (45, 19);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (46, 20);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (47, 21);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (48, 22);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (49, 23);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (50, 24);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (51, 25);
INSERT INTO Partenaire_Adresse (Adresse_id, Partenaire_id) VALUES (52, 26);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (1, "2015-02-28", "Carrossier", 2);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (2, "1996-04-26", "Habitacle", 3);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (3, "1971-07-15", "Mecanicien", 4);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (4, "1970-07-18", "Mecanicien", 5);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (5, "2010-05-27", "Moteur et dependance", 6);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (6, "1970-01-05", "Carrossier", 7);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (7, "1987-03-21", "Accesoires et entretien", 8);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (8, "2005-06-16", "Magasinier", 9);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (9, "1992-05-15", "Habitacle", 10);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (10, "2003-04-16", "Carrossier", 11);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (11, "1997-04-01", "Habitacle", 12);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (12, "1971-02-12", "Habitacle", 13);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (13, "1974-02-06", "Carrossier", 14);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (14, "2001-10-19", "Habitacle", 15);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (15, "2013-05-20", "Carrossier", 16);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (16, "2008-01-22", "Moteur et dependance", 17);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (17, "2011-10-20", "Carrossier", 18);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (18, "1994-08-17", "Habitacle", 19);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (19, "1980-02-08", "Mecanicien", 20);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (20, "2006-03-02", "Mecanicien", 21);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (21, "2001-03-13", "Magasinier", 22);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (22, "1999-06-20", "Carrossier", 23);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (23, "1971-08-10", "Habitacle", 24);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (24, "2000-11-06", "Mecanicien", 25);
INSERT INTO Fiche_salarie (id, dateEmbauche, service, Partenaire_id) VALUES (25, "1992-06-11", "Carrossier", 26);
INSERT INTO Voiture_client (id, immatriculation, dateMiseEnCirculation, Partenaire_id, Modele_de_voiture_id) VALUES (1, "SUA1YRS5XWAML8D83", "1974-10-22", 1, 23);
