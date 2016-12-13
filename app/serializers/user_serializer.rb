class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :email, :nickname

  def avatar
    object.avatar.url
  end
end
