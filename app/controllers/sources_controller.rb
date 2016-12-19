class SourcesController < ApiController
  before_filter :authenticate_user!
  before_filter :set_customer

  def index
    render json: @customer.sources.data
  end

  def create
    @src = @customer.sources.create(source: params[:source])
    @customer.default_source = @src.id

    if @customer.save
      render json: @src
    else
      render json: {
        success: false,
        error: 'Could not save the default source for customer'
      }, status: :unprocessable_entity
    end
  end

  protected

  def set_customer
    @customer = current_user.stripe_instance
  end
end
