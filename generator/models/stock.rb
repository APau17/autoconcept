class Piece < Struct.new(:id,
                         :nom,
                         :designation,
                         :categorie,
                         :restriction,
                         :referenceConstructeur,
                         :compatibiliteApplication,
                         :commentaire,
                         :fichePdf,
                         :Unite_id,
                        )

  def initialize(id = 0)
    self.id = id
    r = Random.new
    self.referenceConstructeur = Faker::Code.asin
    self.nom = Faker::Commerce.product_name
    self.designation = Faker::Vehicule.standard_specs
    self.unite = Faker::Unity.unity
    self.restriction = Faker::Lorem.sentence
    self.compatibiliteApplication = Faker::Lorem.sentence
    self.commentaire = Faker::Lorem.sentence
    self.fichePdf = Faker::Internet.url + ".pdf"
    self.Unite_id = r.rand(1..5)
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
end
