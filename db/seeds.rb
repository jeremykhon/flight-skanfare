# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts"--------------------"
puts "cleaning database"
puts "--------------------"

Deal.destroy_all

puts"--------------------"
puts "creating deals"
puts "--------------------"

deal1 = Deal.create!(depart_date: Date.parse("Dec 8 2018"), return_date: Date.parse("Dec 11 2018"), destination: "BKK", price: 250, origin: "Tokyo" )
deal2 = Deal.create!(depart_date: Date.parse("Dec 9 2018"), return_date: Date.parse("Dec 15 2018"), destination: "HKG", price: 125, origin: "Tokyo" )
deal3 = Deal.create!(depart_date: Date.parse("Dec 10 2018"), return_date: Date.parse("Dec 18 2018"), destination: "BKK", price: 210, origin: "Tokyo" )
deal4 = Deal.create!(depart_date: Date.parse("Dec 11 2018"), return_date: Date.parse("Dec 20 2018"), destination: "PNH", price: 440, origin: "Tokyo" )
deal5 = Deal.create!(depart_date: Date.parse("Dec 12 2018"), return_date: Date.parse("Dec 17 2018"), destination: "HNL", price: 123, origin: "Tokyo" )
deal6 = Deal.create!(depart_date: Date.parse("Dec 13 2018"), return_date: Date.parse("Dec 21 2018"), destination: "HKG", price: 321, origin: "Tokyo" )
deal7 = Deal.create!(depart_date: Date.parse("Dec 14 2018"), return_date: Date.parse("Dec 19 2018"), destination: "HAN", price: 278, origin: "Tokyo" )
deal8 = Deal.create!(depart_date: Date.parse("Dec 15 2018"), return_date: Date.parse("Dec 18 2018"), destination: "PNH", price: 367, origin: "Tokyo" )
deal9 = Deal.create!(depart_date: Date.parse("Dec 16 2018"), return_date: Date.parse("Dec 25 2018"), destination: "HNL", price: 500, origin: "Tokyo" )
deal10 = Deal.create!(depart_date: Date.parse("Dec 17 2018"), return_date: Date.parse("Dec 28 2018"), destination: "HAN", price: 199, origin: "Tokyo" )


puts"------------------------------"
puts "deals successfully created"
puts "-----------------------------"
