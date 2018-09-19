# encoding: utf-8
class UploadsController < ApiController
  before_action :set_upload, only: [:like, :pay, :show, :update, :destroy]
  before_filter :authenticate_user!, only: [:like, :pay, :create, :update, :destroy]

  # GET /uploads
  def index
    @uploads = Upload.includes(:upload_comments, :projects, :user).all

    render json: @uploads
  end

  # GET /uploads/1
  def show
    render json: @upload
  end

  # POST /uploads/1/report
  def report
    @report = current_user.reports.build(upload_id: params[:id])

    if @report.save
      render status: :no_content
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # POST /uploads/1/like
  def like
    @like = current_user.like(@upload)

    if @like
      render status: :no_content
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # POST /uploads/1/pay
  def pay
    render json: Stripe::Charge.create(
      amount: (@upload.amount_to_charge).round, # 1€ per transaction
      currency: 'eur',
      description: "Bezahlung für Upload ##{params[:id]} by #{current_user.to_param}",
      customer: current_user.stripe_customer_id
    )
  rescue Stripe::CardError => e
     render json: { success: false, error: e.message }, status: :unprocessable_entity
  end

  # POST /uploads
  def create
    @upload = UploadService.new({
      :upload => upload_params,
      :supported_projects => params[:supported_projects],
      :user => current_user
    }).run

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
    params.require(:upload).permit(:image, :description)
  end
end
