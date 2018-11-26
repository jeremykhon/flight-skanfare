# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts"--------------------"

City.create!(name: "Hong Kong", code: "HKG-sky", photo: "hongkong_new")
City.create!(name: "Bangkok", code: "BKKT-sky", photo: "bangkok_new")
City.create!(name: "Honolulu", code: "HNLA-sky", photo: "honolulu_new")
City.create!(name: "Seoul", code: "SELA-sky", photo: "seoul_new")
City.create!(name: "Taipei", code: "TPET-sky", photo: "taipei_new")
City.create!(name: "Tokyo", code: "TYOA-sky")
