CREATE VIEW liste_employees AS SELECT nom,prenom,dateNaiss,courriel,telephone,Entreprise_id FROM Partenaire INNER JOIN Contact ON Contact.id=Partenaire.Contact_id;
