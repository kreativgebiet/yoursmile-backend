class Upload::Like < ApplicationRecord
  belongs_to :upload
  belongs_to :author, class_name: 'User'
end
