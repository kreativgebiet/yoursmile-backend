# encoding: utf-8
class Project < ApplicationRecord
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :logo
  validates_presence_of :image
  validates_presence_of :target

  validates_presence_of :sector_code
  validates_presence_of :country_code

  has_and_belongs_to_many :uploads

  mount_uploader :logo
  mount_uploader :image

  validate :valid_country_code

  def upload_count
    uploads.count
  end

  def valid_country_code
    errors.add(:country_code, 'is not valid') if !self.country_code_valid?
  end

  def country_code_valid?
    !ISO3166::Country.new(self.country_code).nil?
  end
end
