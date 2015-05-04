skills = [
  "Piano", 
  "Ruby On Rails", 
  "Cooking", 
  "Italian", 
  "Painting", 
  "Sculpting", 
  "Fishing", 
  "Camping", 
  "Singing", 
  "Sleeping", 
  "Running", 
  "Juggling", 
  "Quiddich", 
  "Hockey", 
  "Cheerleading", 
  "Football", 
  "Freestyle Rap"
]

skills.each do |name|
  Skill.create!(name: name)
end

users = [
  ["Anthony", "To", "Madison", "WI", "53703", "password"],
  ["Alex", "Faber", "Madison", "WI", "53703", "password"],
  ["John", "Doe", "Madison", "WI", "53703", "password"],
  ["Eric", "Miller", "Madison", "WI", "53703", "password"],
  ["Jeanie", "To", "Madison", "WI", "53703", "password"],
  ["Kyle", "Mchesney", "Madison", "WI", "53703", "password"],
  ["Milad", "Torabi", "Madison", "WI", "53703", "password"],
  ["Jasmine", "Kim", "Madison", "WI", "53703", "password"],
  ["Cassie", "Kosky", "Madison", "WI", "53703", "password"],
  ["Rachel", "Bourland", "Madison", "WI", "53703", "password"],
  ["Ethan", "Ward", "Madison", "WI", "53703", "password"],
  ["Rob", "Shepard", "Madison", "WI", "53703", "password"]
]

email_num = 0

skill = Skill.find_by(name: "Cooking")


users.each do |first_name, last_name, city, state, zip_code, password|
  user = User.create( first_name: first_name, 
                last_name: last_name, 
                email: "foo#{email_num}@bar.com", 
                city: city, 
                state: state, 
                zip_code: zip_code, 
                password: password)
  # user.experiences.create(description: "I stink at this", level: 1, skill_id: 1)
  # user.experiences.create(description: "I'm pretty good at this", level: 1, skill_id: rand(1..8))
  # user.experiences.create(description: "somethingsomething blah blah", level: 1, skill_id: rand(1..8))
  email_num += 1
end


