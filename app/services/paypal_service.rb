class PaypalService
  def initialize(params)
    @return_url = params[:return_url]
    @cancel_url = params[:cancel_url]
    @amount = params[:amount]
    @currency = 'EUR'
  end

  def self.execute_payment(payment_id, payer_id)
    payment = PayPal::SDK::REST::Payment.find(payment_id)
    payment.execute(payer_id: payer_id) unless payment.error
    payment
  end

  def create_instant_payment
    payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: { payment_method: "paypal" },
      redirect_urls: { return_url: @return_url, cancel_url: @cancel_url },
      transactions: [{ item_list: { items: get_item_list },
        amount: { total: ActionController::Base.helpers.number_with_precision(@amount, precision: 2),
        currency: @currency }
      }]
    })
    payment.create
    payment
  end

  private
  def get_item_list
    [
        { name: 'Spende', price: @amount, currency: 'EUR', quantity: 1 }
    ]
  end
end
