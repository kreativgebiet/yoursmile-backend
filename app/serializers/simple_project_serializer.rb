class SimpleProjectSerializer < ActiveModel::Serializer
  cache key: 'project', expires_in: 7.days

  attributes :id, :name, :logo

  def logo
    object.logo.url
  end
end
