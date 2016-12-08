# encoding: utf-8
class Upload < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :projects
  has_many :upload_comments, class_name: 'Upload::Comment'
  alias_attribute :comments, :upload_comments

  mount_uploader :image

  validates_presence_of :image
  validates_length_of :projects, minimum: 1
  validates_presence_of :user

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :projects

  def to_s
    "#{description} (#{id})"
  end
end
