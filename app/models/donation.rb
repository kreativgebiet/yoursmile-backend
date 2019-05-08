class Donation
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount, :gateway
  validates :gateway, inclusion: { in: ['stripe', 'paypal'] }
  validates :amount, numericality: { only_integer: true }
end
