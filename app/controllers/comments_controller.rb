# encoding: utf-8
class CommentsController < ApiController
  before_filter :authenticate_user!, except: [:index]
  before_action :set_upload
  before_action :set_comment, only: [:update, :destroy]

  # GET /comments
  def index
    @comments = @upload.comments

    render json: @comments, meta: { upload: UploadSerializer.new(@upload) }
  end

  # POST /comments
  def create
    @comment = @upload.build_comment(comment_params.merge(author_id: current_user.id))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    # TODO: Check if the user is authenticated to update record
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    # TODO: Check if the user is authenticated to update record
    @comment.destroy
  end

  private

  def set_upload
    @upload = Upload.find(params[:upload_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Upload::Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:text)
  end
end
