json.array! @users do |user|
  json.user user
  json.name user.name
  json.id user.id
  json.profile_image user.profile_image
end
