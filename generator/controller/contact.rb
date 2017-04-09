Faker::Config.locale = 'fr'

r = Random.new

partenaires = []
addresses = []
contacts = []
companies = []
contacts_addresses = []
companies_addresses = []
vehicules = []
vehicules_clients = []
salaries = []

# Trade
(1..25).each do |i|
  addresses_id = addresses.length + 1
  addresses.push Address.new(addresses_id)
  companies.push Trade.new(i, addresses_id)
  partenaire_id = partenaires.length + 1
  partenaires.push Partenaire.new(partenaire_id, companies.last.id)
end

# Vehicule models
(1..500).each do |i|
  vehicules.push Vehicule.new(i, partenaires.sample.id)
end

## Company
(1..100).each do |i|

  company_parent_id = nil
  if Faker::Boolean.boolean(0.2)
    company_parent_id = companies.sample.id
  end

  addresses_id = addresses.length + 1
  addresses.push Address.new(addresses_id)

  companies_id = companies.length + 1
  companies.push Entreprise.new(companies_id, addresses_id, company_parent_id)
  partenaire_id = partenaires.length + 1
  partenaires.push Partenaire.new(partenaire_id, companies.last.id)

  contacts_id = contacts.length
  contacts_by_company = r.rand(0...10)

  (0..contacts_by_company).each do ||
    contacts_id += 1
    contacts.push Contact.new(contacts_id)

    addresses_id += 1
    addresses.push Address.new(addresses_id)
    contacts_addresses.push ContactAddress.new(contacts.last.id, partenaires.last.id, addresses_id)

    salaries_id = salaries.length
    if [true, false].sample
      salaries_id += 1
      salaries.push Salarie.new(salaries_id, partenaires.last.id, contacts.last.id)
    end

    vehicules_clients_id = vehicules_clients.length
    vehicules_by_contact = r.rand(0...3)
    (0..vehicules_by_contact).each do ||
      vehicules_clients_id += 1
      vehicules_clients.push VehiculeClient.new(vehicules_clients_id, contacts.last.id, vehicules.sample.id)
    end
  end
end

## Particulier
(1..100).each do |i|
  contacts_id = contacts.length + 1
  addresses_id = addresses.length + 1

  contacts.push Contact.new(contacts_id)
  addresses.push Address.new(addresses_id)

  partenaire_id = partenaires.length + 1
  partenaires.push Partenaire.new(partenaire_id)
  contacts_addresses.push ContactAddress.new(contacts.last.id, partenaires.last.id, addresses.last.id)

  vehicules_clients_id = vehicules_clients.length
  vehicule_by_client = r.rand(0...10)
  (0..vehicule_by_client).each do ||
    vehicules_clients_id += 1
    vehicules_clients.push VehiculeClient.new(vehicules_clients_id, contacts.last.id, vehicules.sample.id)
  end
end

## Display
contacts.each do |contact|
  puts contact.to_h.to_sql_insert("Contact")
end

addresses.each do |address|
  puts address.to_h.to_sql_insert("Adresse")
end

companies.each do |company|
  puts company.to_h.to_sql_insert("Entreprise")
end

partenaires.each do |partenaire|
  puts partenaire.to_h.to_sql_insert("Partenaire")
end

vehicules.each do |vehicule|
  puts vehicule.to_h.to_sql_insert("Modele_de_voiture")
end

contacts_addresses.each do |contact_addresse|
  puts contact_addresse.to_h.to_sql_insert("Contact_Adresse")
end

companies_addresses.each do |company_addresse|
  puts company_addresse.to_h.to_sql_insert("Entreprise_Adresse")
end

vehicules_clients.each do |vehicule_client|
  puts vehicule_client.to_h.to_sql_insert("Voiture_client")
end

salaries.each do |salary|
  puts salary.to_h.to_sql_insert("Fiche_salarie")
end
