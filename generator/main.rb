#!/bin/ruby

require_relative 'faker-autoconcept.rb'
require_relative 'stock.rb'
require_relative 'facturation.rb'
require_relative 'contact.rb'

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
    lots.push Lot.new(piece.id + j, piece.id, emplacements.sample.id, unites.sample.id)
  end
end

lots.each do |lot|
  puts lot.to_h.to_sql_insert("Lot")
end


