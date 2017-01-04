class UserController < ApiController
  before_action :find_user
  before_filter :authenticate_user!, except: [:show, :uploads, :followers, :following]

  def show
    render json: @user
  end

  def uploads
    @uploads = @user.uploads.includes(:user, :projects)
    render json: @uploads, status: :ok
  end

  def follow
    if @user.nil?
      render status: :unprocessable_entity
    else
      current_user.follow @user.id
    end
  end

  def followers
    @followers = @user.followers
    render json: @followers
  end

  def following
    @following = @user.following
    render json: @following
  end

  protected

  def find_user
    @user = User.find params[:id]
  end
end
