# encoding: utf-8
class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session

  def root
    render json: { status: 200, working: true }
  end

  protected

  def pagination
    { test: 'test' }
  end
end
