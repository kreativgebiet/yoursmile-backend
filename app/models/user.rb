# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :uploads
  has_many :likes, class_name: 'Upload::Like'
  has_many :reports, class_name: 'Upload::Report'
  has_many :comments, class_name: 'Upload::Comment'
  has_many :projects, through: :uploads

  validates_uniqueness_of :nickname
  validates_presence_of :nickname
  validates_presence_of :stripe_customer_id

  before_validation :create_stripe_customer_id
  # before_save :ensure_nickname

  mount_uploader :avatar, AvatarUploader

  def follow(user_id)
    Followership.create follower_id: user_id, user_id: self.id
  end

  def followers
    Followership.where(follower_id: self.id)
  end

  def following
    Followership.where(user_id: self.id)
  end

  def like(upload)
    if likes?(upload)
      like_for(upload).destroy
    else
      new_like = likes.build(upload: upload)
      new_like.save
    end
  end

  def likes?(upload)
    !!like_for(upload)
  end

  def like_for(upload)
    self.likes.find_by(upload: upload)
  end

  def to_s
    email
  end

  def regenerate_nickname
    self.nickname = nickname.parameterize
  end

  def create_stripe_customer_id
    if stripe_customer_id.nil? && !email.nil?
      description = "Customer for #{email}"
      customer = Stripe::Customer.create(
        description: description,
        email: email,
        metadata: {
          name: name,
          nickname: nickname,
        }
      )
      self.stripe_customer_id = customer.id
    end
  end

  def stripe_instance
    Stripe::Customer.retrieve(stripe_customer_id)
  end

  def parameterize
    nickname
  end
end
