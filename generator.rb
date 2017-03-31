#!/bin/ruby

require 'faker'

module Faker
  class Vehicule < Base
    class << self
      def standard_specs
        ["1.8L DOHC 16-valve I4 engine -inc: engine cover", "Engine mounts -inc: (2) solid, (1) liquid-filled", "Front wheel drive", "Battery saver", "Independent strut front suspension w/stabilizer bar", "Torsion beam rear suspension w/stabilizer bar", "Electric speed-sensitive variable-assist pwr steering", "Pwr front vented disc/rear drum brakes", "Compact spare tire", "Body color front/rear bumpers", "Multi-reflector halogen headlamps", "Body color folding remote-controlled pwr mirrors", "Variable intermittent windshield wipers w/mist function", "Intermittent rear wiper w/washer", "Body color door handles", "Roof mounted antenna", "Reclining front bucket seats -inc: active head restraints, double-thickness foam in front seats", "60/40 split fold-down rear seat w/outboard adjustable headrests", "Dual front & rear cup holders", "Tilt steering column", "Silver accent IP trim finisher -inc: silver shifter finisher", "Tachometer", "Fasten seat belt warning light/chime", "Pwr windows", "Remote fuel lid release", "Immobilizer system", "Pwr rear liftgate release", "Air conditioning w/in-cabin microfilter", "Rear window defroster w/timer", "12V pwr outlet", "Silver finish interior door handles", "Driver & front passenger map pockets", "Rear passenger map pockets", "Front & rear passenger folding assist grips", "Carpeted floor & cargo area", "Cargo area lamp", "Anti-lock brake system (ABS) -inc: electronic brake force distribution (EBD), brake assist", "Energy absorbing front/rear bumpers", "Steel side-door impact beams", "Zone body construction -inc: front/rear crumple zones, hood deformation point", "Dual-stage front airbags w/occupant classification system", "Front side-impact airbags", "Front & rear side curtain airbags", "3-point ELR driver seat belt w/pretensioner & load limiter", "3-point ELR/ALR front passenger seat belt w/pretensioner & load limiter", "3-point ELR/ALR rear seat belts at all positions", "Child safety rear door locks", "Rear child seat tether anchors (LATCH)", "Tire pressure monitoring system (TPMS)", "Energy absorbing steering column", "4.6L DOHC 32-valve V8 engine -inc: DI & SFI dual fuel injection, dual variable valve timing w/intelligence & electronically controlled intake (VVT-iE), aluminum block & heads", "Vibration-dampening liquid-filled engine mounts", "Electronic throttle control system w/intelligence (ETCS-i)", "Acoustic control induction system (ACIS)", "8-speed automatic transmission -inc: intelligence (ECT-i), gated shifter, sequential sport-shift mode", "Full-time all-wheel drive", "Front/rear aluminum multi-link double joint suspension w/coil springs", "Front/rear stabilizer bars", "Electric pwr rack & pinion steering (EPS)", "4-wheel ventilated pwr disc brakes -inc: brake override system", "Dual chrome exhaust tips", "Tool kit", "P235/50R18 all-season tires", "Full-size spare tire w/aluminum alloy wheel", "Scratch-resistant paint clearcoating", "Pwr tilt/slide moonroof -inc: 1-touch open/close", 
        "1-piece chrome window surround", "Xenon high-intensity discharge (HID) headlamps -inc: adaptive front lighting system, delayed auto-off", "Integrated fog lamps", "LED lights -inc: brake lamps, tail lamps, license plate", "Electrochromic pwr folding heated mirrors w/memory -inc: puddle lamps, integrated turn signals, auto reverse tilt-down", "Acoustic glass windshield", "Water-repellent windshield & front door glass", "Laminated side window glass", "Rain-sensing wipers", "XM satellite radio receiver -inc: 90 day trial subscription", "Rear bench seat -inc: (3) adjustable headrests", "Center console", "Optitron electroluminescent instrumentation", "Multi-info display -inc: driving range, average MPG, current MPG, average speed, outside temp, elapsed time, maintenance & diagnostic messages", "Eco drive indicator", "Pwr windows -inc: 1-touch open/close", "HomeLink universal transceiver", "Dual-zone automatic climate control system -inc: smog sensor, auto recirculation, clear air filter, pollen filter", "Rear-window defogger w/auto-off timer", "(2) aux 12V pwr outlets -inc: (1) in center console, (1) w/cigarette lighter", "Grain-matched wood trim -inc: center console, dash, door panels", "Electrochromic rearview mirror", "Foldable front door storage pockets", "Dual front illuminated visor vanity mirrors", "Front/rear spot-lamp illumination", "4-wheel/4-channel anti-lock brake system (ABS)", "Electronic control braking (ECB)", "Electronic brakeforce distribution (EBD) w/brake assist (BA) -inc: Smart stop technology", "Electronic parking brake", "Vehicle dynamics integrated management (VDIM) system -inc: vehicle stability control (VSC), traction control (TRAC)", "Front/rear crumple zones", "Daytime running lights (DRL)", "Side-impact door beams", "Dual front 2-stage airbags -inc: passenger occupant classification system w/twin-chamber airbag", "Front/rear side curtain airbags", "Dual front knee airbags", "Back-up camera", "All-position 3-point seat belts -inc: outboard pretensioners & force limiters, dual front pwr shoulder height adjusters, rear outboard emergency auto locking retractors, driver emergency locking retractor", "Child restraint seat anchors for outboard positions", "Rear door child safety locks", "Direct-type tire pressure monitor system", "Impact-dissipating upper interior trim", "Collapsible steering column", "Emergency interior trunk release", "First aid kit", "6.1L SRT V8 \"Hemi\" engine", "3.73 axle ratio", "Quadra-Trac active on demand 4WD system", "200mm front axle", "Dana 44/226mm rear axle", "625-amp maintenance-free battery", "160-amp alternator", "Tip start system", "Pwr accessory delay", "Trailer tow wiring harness", "High performance suspension", "Pwr steering cooler", "Pwr rack & pinion performance tuned steering", "Anti-lock 4-wheel performance disc brakes", "Brake assist", "Dual bright exhaust tips", "Run flat tires", "20\" x 9.0\" front & 20\" x 10.0\" rear aluminum wheels", "Monotone paint", 
        "Black roof molding", "Rear body-color spoiler", "Body color grille", "Chrome bodyside molding", "Black windshield molding", "Body color fascias w/bright insert", "Body color sill extension", "Fog lamps", "Front door tinted glass", "\"Flipper\" liftgate glass", "Rear window wiper/washer", "Body color front license plate brow", "Body color door handles", "6.5\" touch screen display", "Fixed long mast antenna", "Pwr 8-way driver seat w/4-way front passenger seat", "60/40 folding rear seat", "Full-length floor console", "Luxury front & rear floor mats w/logo", "Floor carpeting", "Tilt/telescoping steering column", "Leather-wrapped steering wheel w/audio controls", "Instrument cluster w/tachometer", "Vehicle info center", "Traveler/mini trip computer", "Pwr front windows w/(1) touch up/down feature", "Speed control", "Sentry Key theft deterrent system", "Security alarm", "Bright pedals", "Rear window defroster", "Locking glove box", "Highline door trim panel", "Cloth covered headliner", "Overhead console", "Dual illuminated visor vanity mirrors", "Universal garage door opener", "Passenger assist handles", "Deluxe insulation group", "Cargo compartment lamp", "Glove box lamp", "Rear reading & courtesy lamps", "Illuminated entry", "Leather-wrapped shift knob", "Leather-wrapped parking brake handle", "Carpeted cargo area", "Trim-panel-mounted storage net", "Cargo-area tie down loops", "Cargo compartment cover", "Reversible/waterproof cargo storage", "Driver & front passenger advanced multistage airbags w/occupant sensors", "Supplemental side curtain air bags", "Enhanced accident response system unlocks the doors, shuts off the fuel pump and turns on interior lights after airbag deploys", "3-point rear center seat belts", "Child seat upper tether anchorages", "LATCH-ready child seat anchor system", "Child safety rear door locks", "Dual note horn", 
        "Tire pressure monitoring display"].sample
      end

      def type
        ["Citadine", "Compacte"].sample
      end

      def cylinder
        n = [4, 6, 8].sample
        "#{n} Cylinder Engine"
      end

      def energy
      ["Compressed Natural Gas", "Diesel", "E-85/Gasoline", "Electric", "Gasoline", "Gasoline Hybrid"].sample
      end

      def model
        ["328i","M3","M5","X1","X3","X5",
        "A4","A5","S5","A7","A8",
        "Prius","Camry","Corolla",
        "Camero","Silverado","Malibu",
        "Mustang","F150","Focus","Fiesta",
        "Ram","Challenger","Charger","Durango",
        "Navigator","MKZ","MKX","MKS",
        "Enclave","Regal","LaCrosse","Verano","Encore","Riveria",
        "Accord","Civic","CR-V","Odyssey",
        "Rogue","Juke","Cube","Pathfiner","Versa","Altima"].sample
      end
    end
  end

  class Unity < Base
    class << self
      def unity
        ["cm", "m", "kg", "L", "m2", "V", "W"].sample
      end
    end
  end
end

class Piece < Struct.new(:id,
                         :referenceFabricant,
                         :nom,
                         :designation,
                         :marque,
                         :prixUnitaire,
                         :unite,
                         :categorie,
                         :restriction,
                         :compatibiliteApplication,
                         :commentaire,
                         :fichePdf
                        )

  def initialize(id = 0)
    self.id = id
    self.referenceFabricant = Faker::Code.asin
    self.nom = Faker::Commerce.product_name
    self.designation = Faker::Vehicule.standard_specs
    self.marque = Faker::Company.name
    self.prixUnitaire = Faker::Commerce.price
    self.unite = Faker::Unity.unity
    self.categorie = Faker::Commerce.department
    self.restriction = Faker::Lorem.sentence
    self.compatibiliteApplication = Faker::Lorem.sentence
    self.commentaire = Faker::Lorem.sentence
    self.fichePdf = Faker::Internet.url + ".pdf"
  end

  def next
    Piece.new(seld.id + 1)
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

  def next
    Vehicule.new(seld.id + 1)
  end
end

class Emplacement < Struct.new(:id,
                            :nom,
                            :parent_id,
                        )

  def initialize(id = 0, parent_id = 0)
    self.id = id
    self.nom = Faker::Lorem.word
    self.parent_id = parent_id
  end

  def next
    Emplacement.new(seld.id + 1)
  end
end

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

  def next
    Contact.new(seld.id + 1)
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

  def next
    Entrepsie.new(seld.id + 1)
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

  def next
    Salarie.new(seld.id + 1)
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

  def next
    VehiculeClient.new(seld.id + 1)
  end
end

class Lot < Struct.new(:id,
                       :numeroFournisseur,
                       :quantite,
                       :Modele_de_piece,
                       :Unite_id,
                       :Emplacement_id
                        )

  def initialize(id = 0, modele_piece = 1, emplacement = 1, unity = 1)
    self.id = id
    self.numeroFournisseur = Faker::Company.duns_number
    self.quantite = Faker::Number.between(1, 100)
    self.Modele_de_piece = modele_piece
    self.Unite_id = unity
    self.Emplacement_id = emplacement
  end

  def next
    Lot.new(seld.id + 1)
  end
end

class Unity < Struct.new(:id,
                       :nom,
                       :ratio,
                       :Unite_base_id
                        )

  def initialize(id = 0)
    self.id = id
  end

  def next
    Unity.new(seld.id + 1)
  end
end

class Hash
  def to_sql_insert(table)
    str = "INSERT INTO #{table} ("

    self.each do |field, value|
      str += "#{field.to_s}, " if not value.nil?
    end
    

    str = str.chomp(", ")
    str += ") VALUES ("


    self.each do |field, value|
      if not value.nil?
        if value.is_a? String
          str += "\"#{value.to_s}\", "
        else
          str += "#{value.to_s}, "
        end
      end
    end

    str = str.chomp(", ")
    str += ");"
  end
end

r = Random.new

contacts = []
(1..100).each do |i|
  contacts.push Contact.new(i)
end

vehicules = []
(1..100).each do |i|
  vehicules.push Vehicule.new(i)
end

pieces = []
(1..100).each do |i|
  pieces.push Piece.new(i)
end

unites = []
(1..10).each do |i|
  unites.push Unity.new(i)
end

voiture_clients = []
contacts.each do |client|
  voiture_by_contact = r.rand(0...100)
  (0..voiture_by_contact).each do |i|
    voiture_clients.push VehiculeClient.new(i, client.id)
  end
end

salary = []
(1..50).each do |i|
  salary.push Salarie.new(i)
end

company = []
(1..50).each do |i|
  company.push Entreprise.new(i)
end

emplacements = []
(1..50).each do |i|
  emplacements.push Emplacement.new(i)
end

lots = []
pieces.each do |piece|
  piece_by_lot = r.rand(0...100)
  (0..piece_by_lot).each do |j|
    lots.push Lot.new(j, piece.id, emplacements.sample.id, unites.sample.id)
  end
end

lots.each do |lot|
  puts lot.to_h.to_sql_insert("Lot")
end


