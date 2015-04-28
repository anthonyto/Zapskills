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

