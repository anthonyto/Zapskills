json.array!(@experiences) do |experience|
  json.extract! experience, :id, :description, :start_date, :level, :user_id, :skill_id
  json.url experience_url(experience, format: :json)
end
