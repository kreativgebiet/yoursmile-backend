class UploadSerializer < ActiveModel::Serializer
  attributes :id, :image, :author, :description, :created_at

  belongs_to :user, key: :author

  def image
    object.image.url
  end

  def author
    object.user.avatar.url
  end
end
