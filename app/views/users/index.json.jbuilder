json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :email, :city, :state, :zip_code, :date_of_birth, :password, :profile_picture_url
  json.url user_url(user, format: :json)
end
