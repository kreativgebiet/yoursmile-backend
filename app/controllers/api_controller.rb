# encoding: utf-8
class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def root
    render text: 'Nothing to see here.'
  end

  protected

  def pagination
    {
      test: 'test'
    }
  end
end
