class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    !session[:user_id].nil? 
  end
 
  def current_user
    @user = session[:user_id] ? User.find(session[:user_id]) : User.new
  end

  def restrict_access
    if !current_user
      flash[:alert] = "Please log in before proceedint."
      redirect_to new_session_path
    end 
  end

  helper_method :logged_in?, :current_user
end
