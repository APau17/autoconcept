class Contact < Struct.new(:id,
                            :nom,
                            :prenom,
                            :sexe,
                            :dateNaiss,
                            :adresse,
                            :ville,
                            :code_postal
                        )

  def initialize(id = 0, parent_id = 0)
    self.id = id
    self.nom = Faker::Name.last_name
    self.prenom = Faker::Name.first_name
    self.sexe = [0, 1].sample
    self.dateNaiss = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.adresse = Faker::Address.street_address
    self.ville = Faker::Address.city
    self.code_postal = Faker::Address.zip_code
  end
end

class Vehicule < Struct.new(:id,
                            :marque,
                            :modele,
                            :classe,
                            :annee,
                            :motorisation,
                            :carburantEnergie
                        )

  def initialize(id = 0)
    self.id = id
    self.marque = Faker::Vehicle.manufacture
    self.modele = Faker::Vehicule.model
    self.classe = Faker::Vehicule.type
    self.annee = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.motorisation = Faker::Vehicule.cylinder
    self.carburantEnergie = Faker::Vehicule.energy
  end
end

class Entreprise < Struct.new(:id,
                              :raisonSociale,
                              :siret,
                              :siegeSocial,
                              :codePostal,
                              :ville,
                        )

  def initialize(id = 0)
    self.id = id
    self.raisonSociale = Faker::Company.name
    self.siret = Faker::Company.ein
    self.siegeSocial = Faker::Address.street_address
    self.codePostal = Faker::Address.zip
    self.ville = Faker::Address.city
  end
end

class Salarie < Struct.new(:id,
                           :dateEmbauche,
                           :service
                        )

  def initialize(id = 0)
    self.id = id
    self.dateEmbauche = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.service = Faker::Commerce.department(1, true)
  end
end

class VehiculeClient < Struct.new(:id,
                                  :immatriculation,
                                  :dateMiseEnCirculation,
                                  :Contact_id,
                                  :Modele_de_voiture_id
                        )

  def initialize(id = 0, contact_id = 1, modele_voiture = 1)
    self.id = id
    self.immatriculation = Faker::Vehicle.vin
    self.dateMiseEnCirculation = Faker::Time.between(DateTime.new(1970), DateTime.now).to_date.iso8601
    self.Contact_id = contact_id
    self.Modele_de_voiture_id = modele_voiture
  end
end
