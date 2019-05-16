class DonationsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_filter :authenticate_user!, only: [:new, :create]
  before_action :set_user_by_token
  before_action :set_project

  def new
    @donation = Donation.new(donation_params)
    unless @donation.valid?
      raise ActionController::BadRequest.new(), @donation.errors.full_messages.join(', ')
    end

    session[:donation_amount] = @donation.amount
  end

  def paypal
    @amount = session[:donation_amount].to_i
    unless @amount
      raise ActionController::BadRequest.new(), 'No donation amount'
    end

    # check whether there was an error happened when created the payment
    if (@payment = new_paypal_service).error.nil?
      # The url to redirect the buyer
      @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
      # save other @payment data if you need
      redirect_to @redirect_url
    else
      # if the payment is not created successfully,
      # the error message will be saved in @payment.error
      @message = @payment.error
      # Show the error message to user
    end
  end

  def paypal_callback
    payment_id = params.fetch(:paymentId, nil)
    if payment_id.present?
      @payment = execute_paypal_payment({
                                            token: payment_id, payment_id: payment_id,
                                            payer_id: params[:PayerID]})
    end

    if @payment && @payment.success?
      render :success
    else
      render :error
    end
  end

  def stripe
    @amount = session[:donation_amount].to_i
    unless @amount
      raise ActionController::BadRequest.new(), 'No donation amount'
    end
  end

  def stripe_charge
    @amount = session[:donation_amount].to_i
    unless @amount
      raise ActionController::BadRequest.new(), 'No donation amount'
    end

    @token = params[:token]
    unless @token
      raise ActionController::BadRequest.new(), 'Token missing'
    end

    Stripe::Charge.create({
      amount: @amount * 100,
      currency: 'EUR',
      source: @token, # obtained with Stripe.js
      description: "Spende für Projekt \"#{@project.name}\" von #{current_user.nickname}",
    })

    render text: 'success'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def donation_params
    params.permit(:amount)
  end

  def sign_in_using_token
    return unless params['access-token']
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def resource_name
    :user
  end

  def execute_paypal_payment(params)
    PaypalService.execute_payment(params[:payment_id], params[:payer_id])
  end

  def new_paypal_service
    PaypalService.new({
      amount: @amount,
      return_url: url_for(action: :paypal_callback),
      cancel_url: url_for(action: :new) + '?amount=' + @amount.to_s,
    }).create_instant_payment
  end
end
