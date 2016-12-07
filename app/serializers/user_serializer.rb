class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :email

  def avatar
    object.avatar.url
  end
end
