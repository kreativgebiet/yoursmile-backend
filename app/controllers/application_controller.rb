class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  def root
    render text: 'Nothing to see here.'
  end

  protected

  def pagination(object)
    {
      test: 'test'
    }
  end
end
