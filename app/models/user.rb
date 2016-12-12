# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :uploads
  has_many :comments, class_name: 'Upload::Comment'

  validates_uniqueness_of :nickname
  validates_presence_of :nickname

  mount_uploader :avatar, AvatarUploader

  def to_s
    email
  end

  def parameterize
    nickname
  end

  # def to_param
  #   nickname
  # end
end
