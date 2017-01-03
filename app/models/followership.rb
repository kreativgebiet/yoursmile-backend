class Followership < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: 'Person'
end
