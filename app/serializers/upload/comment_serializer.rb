class Upload::CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at
  belongs_to :author
end
