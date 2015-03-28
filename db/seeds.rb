# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

skills = [
  "Piano", 
  "Ruby On Rails", 
  "Cooking", 
  "Italian", 
  "Painting", 
  "Sculpting", 
  "Fishing", 
  "Camping"
]

skills.each do |name|
  Skill.create!(name: name)
end

users = [
  ["Anthony", "To", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Alex", "Faber", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["John", "Doe", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Eric", "Miller", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Jeanie", "To", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Kyle", "Mchesney", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Milad", "Torabi", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Jasmine", "Kim", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Cassie", "Kosky", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Rachel", "Bourland", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Ethan", "Ward", "Madison", "WI", "53703", "01/10/1993", "password"],
  ["Rob", "Shepard", "Madison", "WI", "53703", "01/10/1993", "password"]
]

email_num = 0

skill = Skill.find_by(name: "cooking")


users.each do |first_name, last_name, city, state, zip_code, date_of_birth, password|
  user = User.create!( first_name: first_name, 
                last_name: last_name, 
                email: "foo#{email_num}@bar.com", 
                city: city, 
                state: state, 
                zip_code: zip_code, 
                date_of_birth: date_of_birth, 
                password: password)
  user.experiences.create!(description: "Do this errday", level: 1, skill: skill)
  email_num += 1
end


