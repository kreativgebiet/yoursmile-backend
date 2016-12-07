class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :logo, :created_at

  def logo
    object.logo.url
  end

  def image
    object.image.url
  end
end
