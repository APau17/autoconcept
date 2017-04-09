class Partenaire < Struct.new(:id,
                              :Entreprise_id,
                        )

  def initialize(id, entreprise_id = nil)
    self.id = id
    self.Entreprise_id = entreprise_id
  end
end

class Contact < Struct.new(:id,
                            :nom,
                            :prenom,
                            :sexe,
                            :dateNaiss,
                            :courriel,
                            :telephone
                        )

  def initialize(id)
    self.id = id
    self.nom = Faker::Name.last_name
    self.prenom = Faker::Name.first_name
    self.sexe = [0, 1].sample
    self.dateNaiss = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.telephone = Faker::Base.numerify('0#########')
    self.courriel = Faker::Internet.email
  end
end

class Relation < Struct.new(:id,
                            :nom,
                            :facturable,
                            :livrable,
                        )

  def initialize(id, nom, factuable = nil, livrable = nil)
    self.id = contact_id
    self.nom = nom
    self.facturable = factuable
    self.livrable = livrable
  end
end

class PartenaireContact < Struct.new(:Contact_id,
                                     :Partenaire_id,
                                     :Relation_id
                        )

  def initialize(contact_id, partenaire_id, relation_id)
    self.Contact_id = contact_id
    self.Partenaire_id = partenaire_id
    self.Relation_id = relation_id
  end
end

class Address < Struct.new(:id,
                            :adresse,
                            :ville,
                            :codePostal,
                        )

  def initialize(id)
    self.id = id
    self.adresse = Faker::Address.street_address
    self.ville = Faker::Address.city
    self.codePostal = Faker::Address.zip_code
  end
end

class ContactAddress < Struct.new(:Contact_id,
                                  :Adresse_id,
                                  :Partenaire_id,
                        )

  def initialize(contact_id, partenaire_id, address_id)
    self.Contact_id = contact_id
    self.Adresse_id = address_id
    self.Partenaire_id = partenaire_id
  end
end

class ContactEntreprise < Struct.new(:Contact_id,
                                     :Entreprise_id,
                        )

  def initialize(contact_id, entreprise_id)
    self.Contact_id = contact_id
    self.Entreprise_id = entreprise_id
  end
end

class EntrepriseAddress < Struct.new(:Entreprise_id,
                                     :Adresse_id,
                                     :parent_id,
                        )

  def initialize(contact_id, address_id, parent_id = nil)
    self.Entreprise_id = contact_id
    self.Adresse_id = address_id
    self.parent_id = parent_id
  end
end

class Vehicule < Struct.new(:id,
                            :modele,
                            :classe,
                            :annee,
                            :motorisation,
                            :carburantEnergie,
                            :Partenaire_id
                        )

  def initialize(id, partenaire_id)
    self.id = id
    self.modele = Faker::Vehicule.model
    self.classe = Faker::Vehicule.type
    self.annee = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.motorisation = Faker::Vehicule.cylinder
    self.carburantEnergie = Faker::Vehicule.energy
    self.Partenaire_id = partenaire_id
  end
end

class Entreprise < Struct.new(:id,
                              :raisonSociale,
                              :siret,
                              :logo,
                              :parent_id,
                              :Adresse_id
                        )

  def initialize(id, adresse_id, parent_id = nil)
    self.id = id
    self.raisonSociale = Faker::Company.name
    self.siret = Faker::Company.unique.siret
    self.logo = Faker::Avatar.image
    self.parent_id = parent_id
    self.Adresse_id = adresse_id
  end
end

class Trade < Entreprise
  def initialize(id, address_id, parent_id = nil)
    super id, address_id, parent_id
    self.raisonSociale = Faker::Vehicle.manufacture
  end
end

class Salarie < Struct.new(:id,
                           :dateEmbauche,
                           :service,
                           :Contact_id,
                           :Partenaire_id
                        )

  def initialize(id, partenaire_id, contact_id)
    self.id = id
    self.dateEmbauche = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.service = Faker::Commerce.department(1, true)
    self.Contact_id = contact_id
    self.Partenaire_id = partenaire_id
  end
end

class VehiculeClient < Struct.new(:id,
                                  :immatriculation,
                                  :dateMiseEnCirculation,
                                  :Contact_id,
                                  :Modele_de_voiture_id
                        )

  def initialize(id, contact_id, modele_voiture)
    self.id = id
    self.immatriculation = Faker::Vehicle.vin
    self.dateMiseEnCirculation = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.Contact_id = contact_id
    self.Modele_de_voiture_id = modele_voiture
  end
end
