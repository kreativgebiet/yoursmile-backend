# encoding: utf-8
class UploadsController < ApiController
  before_action :set_upload, only: [:pay, :show, :update, :destroy]
  before_filter :authenticate_user!, only: [:pay, :create, :update, :destroy]

  # GET /uploads
  def index
    @uploads = Upload.includes(:upload_comments, :projects, :user).all

    render json: @uploads
  end

  # GET /uploads/1
  def show
    render json: @upload
  end

  def pay
    render json: Stripe::Charge.create(
      amount: ((@upload.projects.count * 100) * 1.4 + 35).round, # 1€ per transaction
      currency: 'eur',
      description: "Bezahlung für Upload ##{params[:id]} by #{current_user.to_param}",
      customer: current_user.stripe_customer_id
    )
  rescue Stripe::CardError => e
     render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  # POST /uploads
  def create
    @upload = Upload.new upload_params.merge(user: current_user)

    if @upload.save
      render json: @upload, status: :created, location: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  def update
    # TODO: Check if the user is authenticated to update record
    if @upload.update(upload_params)
      render json: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /uploads/1
  def destroy
    # TODO: Check if the user is authenticated to update record
    @upload.destroy
  end

  private

  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def upload_params
    params.require(:upload).permit(:image, :description, project_ids: [])
  end
end
