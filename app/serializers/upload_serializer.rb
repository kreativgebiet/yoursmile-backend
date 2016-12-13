class UploadSerializer < ActiveModel::Serializer
  attributes :id, :image, :author, :description, :comment_count, :created_at

  has_many :projects
  belongs_to :user, key: :author

  def image
    object.image.url
  end

  def author
    object.user.avatar.url
  end

  def comment_count
    object.comments.count
  end
end
