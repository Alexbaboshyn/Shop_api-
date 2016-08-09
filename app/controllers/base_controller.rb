class BaseController < ApplicationController

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.user.joins(:auth_token).find_by(auth_tokens: { value: token })
    end
  end
end
