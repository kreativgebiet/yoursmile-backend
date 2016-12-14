class SimpleProjectSerializer < ActiveModel::Serializer
  cache key: 'project', expires_in: 24.hours

  attributes :id, :name, :logo

  def logo
    object.logo.url
  end
end
