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
]

email_num = 0

skill = Skill.find_by(name: "Camping")


users.each do |first_name, last_name, city, state, zip_code, date_of_birth, password|
  user = User.create( first_name: first_name, 
                last_name: last_name, 
                email: "foo#{email_num}@bar.com", 
                city: city, 
                state: state, 
                zip_code: zip_code, 
                date_of_birth: date_of_birth, 
                password: password)
  user.experiences.create(description: "I stink at this", level: 1, skill_id: skill.id)
  # user.experiences.create(description: "I'm pretty good at this", level: 1, skill_id: rand(1..8))
  # user.experiences.create(description: "somethingsomething blah blah", level: 1, skill_id: rand(1..8))
  email_num += 1
end


