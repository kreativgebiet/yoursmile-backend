# encoding: utf-8
class Upload < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :projects
  has_many :comments, class_name: 'Upload::Comment'

  mount_uploader :image

  validates_presence_of :image
  validates_length_of :projects, minimum: 1
  validates_presence_of :user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :projects
end
