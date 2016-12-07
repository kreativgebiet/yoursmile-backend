# encoding: utf-8
class Project < ApplicationRecord
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :logo
  validates_presence_of :image

  has_and_belongs_to_many :uploads

  mount_uploader :logo
  mount_uploader :image

  def upload_count
    uploads.count
  end
end
