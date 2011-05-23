# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'CSV'

#Postcodes import
csv_postcodes = File.read(File.join(Rails.root, 'db', 'seed_data', 'postcodes.csv'))
csv_postcodes = CSV.parse(csv_postcodes, :headers => true)
csv_postcodes.each do |row|
  row = row.to_hash.with_indifferent_access
  Postcode.create!(row.to_hash.symbolize_keys)
end

#People import
csv_people = File.read(File.join(Rails.root, 'db', 'seed_data', 'people.csv'))
csv_people = CSV.parse(csv_people, :headers => true)
csv_people.each do |row|
  row = row.to_hash.with_indifferent_access
  Person.create!(row.to_hash.symbolize_keys)
end
