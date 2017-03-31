# Bon de commande
ALTER TABLE Bon_de_commande ADD CONSTRAINT FK_Bon_de_commande_Contact_id FOREIGN KEY (Contact_id) REFERENCES Contact(id);
ALTER TABLE Bon_de_commande ADD CONSTRAINT FK_Bon_de_commande_Litige_id FOREIGN KEY (Litige_id) REFERENCES Litige(id);
ALTER TABLE Bon_de_commande ADD CONSTRAINT FK_Bon_de_commande_Contact_1_id FOREIGN KEY (Contact_1_id) REFERENCES Contact(id);

# Lot
ALTER TABLE Lot ADD CONSTRAINT FK_Lot_Modele_de_piece_id FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id);

# Modèle
ALTER TABLE Modele_de_piece ADD CONSTRAINT FK_Modele_de_piece_Contact_id FOREIGN KEY (Contact_id) REFERENCES Contact(id);

# Litige
ALTER TABLE Litige ADD CONSTRAINT FK_Litige_Bon_de_commande_id FOREIGN KEY (Bon_de_commande_id) REFERENCES Bon_de_commande(id);

# Client
ALTER TABLE Client ADD CONSTRAINT FK_Client_id FOREIGN KEY (id) REFERENCES Contact(id);

# Voiture des clients
ALTER TABLE Voiture_client ADD CONSTRAINT FK_Voiture_client_Contact_id FOREIGN KEY (Contact_id) REFERENCES Contact(id);
ALTER TABLE Voiture_client ADD CONSTRAINT FK_Voiture_client_Modele_de_voiture_id FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id);

# Fournisseur
ALTER TABLE Fournisseur ADD CONSTRAINT FK_Fournisseur_id FOREIGN KEY (id) REFERENCES Contact(id);

# Ligne de commande
ALTER TABLE Ligne_de_commande ADD CONSTRAINT FK_Ligne_de_commande_Bon_de_commande_id FOREIGN KEY (Bon_de_commande_id) REFERENCES Bon_de_commande(id);
ALTER TABLE Ligne_de_commande ADD CONSTRAINT FK_Ligne_de_commande_Modele_de_piece_id FOREIGN KEY (Modele_de_piece_id) REFERENCES Modele_de_piece(id);

# Lot emplacement
ALTER TABLE Lot_Emplacement ADD CONSTRAINT FK_Lot_Emplacement_id FOREIGN KEY (id) REFERENCES Lot(id);
ALTER TABLE Lot_Emplacement ADD CONSTRAINT FK_Lot_Emplacement_Emplacement_id FOREIGN KEY (Emplacement_id) REFERENCES Emplacement(id);

# Emplacement
ALTER TABLE Emplacement ADD CONSTRAINT FK_Emplacement_id_Emplacement FOREIGN KEY (parent_id) REFERENCES Emplacement(id);

# Contact fiche
ALTER TABLE Contact_Fiche salarié_Entreprise ADD CONSTRAINT FK_Contact_Fiche_salarie_Entreprise_id FOREIGN KEY (id) REFERENCES Entreprise(id);
ALTER TABLE Contact_Fiche salarié_Entreprise ADD CONSTRAINT FK_Contact_Fiche_salarie_Entreprise_Contact_id FOREIGN KEY (Contact_id) REFERENCES Contact(id);
ALTER TABLE Contact_Fiche salarié_Entreprise ADD CONSTRAINT FK_Contact_Fiche_salarie_Entreprise_Fiche_salarie_id FOREIGN KEY (Fiche_salarie_id) REFERENCES Fiche_salarie(id);

# Compatibilite
ALTER TABLE Compatibilite ADD CONSTRAINT FK_Compatibilite_id FOREIGN KEY (id) REFERENCES Modele_de_piece(id);
ALTER TABLE Compatibilite ADD CONSTRAINT FK_Compatibilite_Modele_de_voiture_id FOREIGN KEY (Modele_de_voiture_id) REFERENCES Modele_de_voiture(id);
