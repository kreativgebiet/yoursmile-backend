class AddStripeCustomerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_customer_id, :string

    User.find_each do |user|
      # user.regenerate_nickname
      user.create_stripe_customer_id
      user.save!
    end
  end
end
