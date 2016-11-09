# encoding: utf-8
class Upload < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_and_belongs_to_many :projects
end
