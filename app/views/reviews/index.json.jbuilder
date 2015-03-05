json.array!(@reviews) do |review|
  json.extract! review, :id, :reviewer, :reviewee, :skill, :stars, :description
  json.url review_url(review, format: :json)
end
