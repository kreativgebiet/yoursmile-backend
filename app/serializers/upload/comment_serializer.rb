class Upload::CommentSerializer < ActiveModel::Serializer
  cache key: 'comment', expires_in: 7.days

  attributes :id, :text, :created_at
  belongs_to :author
end
