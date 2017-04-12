require 'faker'

module Faker
  class Vehicule < Base
    class << self
      def modele_de_piece
        ["phare xenon", "Liquide de frein", "Moteur", "Turbo", "Essuis-glace", "Jantes" + "-" + Faker::Base.numerify("##"), "Roue" + "-" + Faker::Base.numerify("##"), "Retroviseur", "Pare-brise", "Pot echappement"].sample
      end

      def type
        ["Citadine", "Compacte","sportive","break"].sample
      end

      def cylinder
        n = [4, 6, 8].sample
        "#{n} cylindres"
      end

      def energy
      ["Gaz naturel compressé", "Diesel", "E-85/Essence", "Électrique", "Essence", "Essence Hybrid"].sample
      end
	  
	  def service
	    ["Carrossier", "Mecanicien", "Magasinier", "Moteur et dependance", "Accesoires et entretien", "Habitacle"].sample
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
	  
	  def immatriculation
		Faker::Base.letterify("??") + "-" + Faker::Base.numerify("###") + "-" + Faker::Base.letterify("??")
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

  class Company < Base
    class << self
      def siret
        Faker::Base.numerify('##############')
      end
    end
  end
end
