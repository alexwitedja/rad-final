# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

City.delete_all
Timezone.delete_all
Clock.delete_all

timezone_list = JSON.parse(File.read("#{Rails.root}/db/zone.json"))

timezone_list.each do |timezone|
    t_item = Timezone.create!(timezone.to_h)
    t_item.utc.each do |city|
        country = city.split("/")[0]
        name = city.split("/")[1]
        t_item.cities.create!("city": city, "country": country, "name": name)
    end
end

Clock.create!(city: "Melbourne")
Clock.create!(city: "Tokyo")
Clock.create!(city: "Hawaii")