class UserController < ApiController
  before_filter :authenticate_user!, except: [:show, :uploads, :followers, :following]

  def show
    @user = User.find params[:id]
    render json: @user
  end

  def uploads
    @uploads = User.find(params[:id]).uploads.includes(:user, :projects)
    render json: @uploads, status: :ok
  end

  def follow
    @user = User.find_by id: params[:id]

    if @user.nil?
      render status: :unprocessable_entity
    else
      current_user.follow @user.id
    end
  end

  def followers
    @followers = current_user.followers
    render json: @followers
  end

  def following
    @following = current_user.following
    render json: @following
  end
end
