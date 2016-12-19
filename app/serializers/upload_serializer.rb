class UploadSerializer < ActiveModel::Serializer
  attributes :id, :image, :description, :comment_count, :created_at, :author, :projects

  belongs_to :user, key: :author

  def projects
    object.projects.map do |project|
      SimpleProjectSerializer.new(project)
    end
  end

  def image
    object.image.url
  end

  def author
    object.user.avatar.url
  end

  def comment_count
    object.comments.length
  end
end
