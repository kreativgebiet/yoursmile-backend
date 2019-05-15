class Donation
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount, :gateway
  validates :amount, numericality: { only_integer: true }
end
