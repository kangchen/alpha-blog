class ApplicationController < ActionController::Base
  before_action :avator_image
  # protect_from_forgery with: :exception

  helper_method :current_user, :avator_image, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def avator_image
    if logged_in?
      @avator_image = Avator.where("uid = ?", current_user.id.to_s)
    end
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
