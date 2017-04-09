#!/bin/ruby

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

require_relative 'faker/faker-autoconcept.rb'
require_relative 'models/main.rb'
require_relative 'controller/main.rb'
