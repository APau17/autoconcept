Faker::Config.locale = 'fr'

class Companies < Array
  def initialize(addresses)
    super()
    @id = 0
    @addresses = addresses
  end

  def push
    @id += 1
    super Entreprise.new(@id, @addresses.push)
    return @id
  end

  def push_child(child)
    parent_id = push
    (1..child).each do ||
      @id += 1
      address = @addresses.push
      super Entreprise.new(@id, address, parent_id)
    end
    return @id
  end

  def push_trade
    @id += 1
    method(:push).super_method.call Trade.new(@id, @addresses.push)
    return @id
  end
end

class Addresses < Array
  def initialize
    super()
    @id = 0
  end

  def push
    @id += 1
    super Address.new(@id)
    return @id
  end
end

class Vehicules < Array
  def initialize(companies)
    super()
    @id = 0
    @companies = companies
  end

  def push
    @id += 1
    super Vehicule.new(@id, @companies.sample.id)
    return @id
  end
end

class Contacts < Array
  def initialize
    super()
    @id = 0
  end

  def push
    @id += 1
    super Contact.new(@id)
    return @id
  end
end

class Partenaires < Array
  def initialize(contacts, addresses, partenaires_addresses)
    super()
    @id = 0
    @contacts = contacts
    @addresses = addresses
    @partenaires_addresses = partenaires_addresses
  end

  def push(entreprise, contact)
    r = Random.new
    @id += 1
    partenaire = Partenaire.new(@id, contact, entreprise, r.rand(1..5))
    address = @addresses.push
    @partenaires_addresses.push partenaire.id, address
    super partenaire
    return @id
  end

  def push_salarie(entreprise)
    push entreprise, @contacts.push
  end

  def push_particulier
    push(nil, @contacts.push)
  end
end

class PartenairesAddresses < Array
  def initialize
    super()
  end

  def push(partenaire_id, address_id)
    super PartenaireAddress.new(partenaire_id, address_id)
  end
end

class Salaries < Array
  def initialize(partenaire)
    super()
    @id = 0
    @partenaire = partenaire
  end

  def push(entreprise)
    @id += 1
    super Salarie.new(@id, @partenaire.push_salarie(entreprise))
    return @id
  end
end

class VehiculesClient < Array
  def initialize(vehicules)
    super()
    @id = 0
    @vehicules = vehicules
  end

  def push(partenaire_id)
    @id += 1
    super VehiculeClient.new(@id, partenaire_id, @vehicules.sample.id)
    return @id
  end
end

class ScenarioParticulier
  def initialize(tables)
    @tables = tables
  end

  def add
    partenaire = @tables[:Partenaire].push_particulier
    @tables[:Voiture_client].push partenaire
  end
end

class ScenarioTrade
  def initialize(tables, count = 25)
    @tables = tables

    (1..25).each do ||
      @tables[:Entreprise].push_trade
      @tables[:Modele_de_voiture].push
    end
  end
end

class ScenarioProfessionel
  def initialize(tables)
    @tables = tables
  end

  def add(salaries_count)
    entreprise = @tables[:Entreprise].push

    (1..salaries_count).each do ||
      @tables[:Fiche_salarie].push entreprise
    end
  end
end

addresses = Addresses.new
contacts = Contacts.new
companies = Companies.new(addresses)
vehicules = Vehicules.new(companies)
partenaires_addresses = PartenairesAddresses.new
partenaires = Partenaires.new(contacts, addresses, partenaires_addresses)
salaries = Salaries.new(partenaires)
vehicules_client = VehiculesClient.new(vehicules)

tables = {
  Adresse: addresses,
  Entreprise: companies,
  Modele_de_voiture: vehicules,
  Contact: contacts,
  Partenaire: partenaires,
  Partenaire_Adresse: partenaires_addresses,
  Fiche_salarie: salaries,
  Voiture_client: vehicules_client,
}

ScenarioTrade.new(tables)
ScenarioParticulier.new(tables).add
ScenarioProfessionel.new(tables).add(25)

tables.each do |name, rows|
  rows.each do |row|
    puts row.to_h.to_sql_insert(name.to_s)
  end
end
