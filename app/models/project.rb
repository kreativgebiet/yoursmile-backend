# encoding: utf-8
class Project < ApplicationRecord
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :logo

  has_and_belongs_to_many :uploads

  def upload_count
    uploads.count
  end
end
