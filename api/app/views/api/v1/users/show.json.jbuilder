json.success true

json.required_point @required_point

json.user do
  json.provider @user.provider
  json.upload_image @user.image?
  json.image_url do
    json.mini "#{Settings['base_image_url']}#{@user.image_url(:mini)}"
    json.small "#{Settings['base_image_url']}#{@user.image_url(:small)}"
    json.medium "#{Settings['base_image_url']}#{@user.image_url(:medium)}"
    json.large "#{Settings['base_image_url']}#{@user.image_url(:large)}"
    json.xlarge "#{Settings['base_image_url']}#{@user.image_url(:xlarge)}"
  end
  json.id @user.id
  json.name @user.name
  json.email @user.email
  json.level @user.level
  json.username @user.username
  json.profile @user.profile
  if @user.prefecture_id.present?
    json.prefecture do
      json.id @prefecture.id
      json.name @prefecture.name
    end
  end
  if @user.city_id.present?
    json.city do
      json.id @city.id
      json.name @city.name
    end
  end
  json.lifelong_point @user.lifelong_point
  json.point_to_next @user.point_to_next
  json.infomation_unread_count @user.infomation_unread_count
  json.created_at @user.created_at.present? ? l(@user.created_at, format: :json) : nil
end
