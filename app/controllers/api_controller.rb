# encoding: utf-8
class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def root
    render json: { status: 200, working: true }
  end

  protected

  def pagination
    { test: 'test' }
  end
end
