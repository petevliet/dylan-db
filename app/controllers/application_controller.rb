class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  # This error will be raised when lyrics are not found by gem i.e., Dylan didn't write the song
  class NotFound < StandardError
  end
  rescue_from NoMethodError, with: :not_found

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(twitter_id: session[:user_id])
    end
  end

  private
  def not_found
    render '../../public/500', status: 500, layout: false
  end

end
