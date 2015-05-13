# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cat1 = Cat.create!(birthdate: '11-1-2013'.to_date, color: "Gray", name: "Schrodenger", sex: "M", description: "Poisoned")
cat2 = Cat.create!(birthdate: '11-3-2012'.to_date, color: "White", name: "Feynman", sex: "M", description: "Manhattan Project")
cat3 = Cat.create!(birthdate: '11-12-2014'.to_date, color: "Black", name: "Curie", sex: "F", description: "Radium poisoning")

cr1 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '1-5-2015', end_date: '5-5-2015')
cr2 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '3-5-2015', end_date: '6-5-2015')
cr3 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '7-5-2015', end_date: '9-5-2015')
