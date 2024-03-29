# encoding: utf-8
class Upload < ApplicationRecord
  belongs_to :user
  alias_attribute :author, :user

  has_many :likes, class_name: 'Upload::Like'
  has_many :reports, class_name: 'Upload::Report'
  has_many :supports, class_name: 'Upload::Support'
  has_many :projects, through: :supports
  has_many :upload_comments, class_name: 'Upload::Comment'
  alias_attribute :comments, :upload_comments

  mount_uploader :image, ImageUploader

  # validates_presence_of :image
  # validates_length_of :projects, minimum: 1
  validates_presence_of :user

  # validate :project_target_not_exceeded

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :projects

  def to_s
    "#{description} (#{id})"
  end

  def amount_to_charge
    supports.sum(:amount)
  end

  # def project_target_not_exceeded
  #   errors.add(:project, 'target is can\'t be exceeded') unless project.target > project.uploads.count
  # end
end
