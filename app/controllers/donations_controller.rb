class DonationsController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_filter :authenticate_user!, only: [:new, :create]
  before_action :set_user_by_token
  before_action :set_project

  def new
    @donation = Donation.new(amount: 10)
  end

  def stripe

  end

  def create
    @donation = Donation.new(donation_params)
    unless @donation.valid?
      flash[:error] = @donation.errors.full_messages.join(', ')
      render :new
    else
      case @donation.gateway
      when 'stripe'
        puts Stripe::Charge.create(
            amount: @donation.amount,
            currency: 'eur',
            description: "Spende für Projekt #{@project.name}"
        ).inspect
      end
    end
  end
  private

  # Only allow a trusted parameter "white list" through.
  def donation_params
    params.require(:donation).permit(:amount, :gateway)
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
