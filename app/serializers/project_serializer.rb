class ProjectSerializer < ActiveModel::Serializer
  cache key: 'project', expires_in: 7.days

  attributes :id, :name, :description, :image, :logo, :created_at, :target, :progress, :country_code, :sector_code

  def progress
    object.target - object.uploads.count
  end

  def logo
    object.logo.url
  end

  def image
    object.image.url
  end
end
