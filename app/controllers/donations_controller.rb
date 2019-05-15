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

    render text: 'yeah'
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
end
