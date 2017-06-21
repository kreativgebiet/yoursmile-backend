class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :email, :nickname, :followers_count, :following_count, :supported_projects

  def followers_count
    object.followers.count
  end

  def following_count
    object.following.count
  end

  def avatar
    object.avatar.url
  end

  def supported_projects
    object.projects
  end
end
