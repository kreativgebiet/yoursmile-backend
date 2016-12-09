# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :comments

  validates_presence_of :nickname

  mount_uploader :avatar

  def to_s
    email
  end

  def to_param
    nickname
  end
end
