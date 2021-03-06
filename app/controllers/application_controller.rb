class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_admin
    if !current_user.admin? && logged_in?
      flash[:danger] = 'Only admin user can perform that action'
      redirect_to root_path
    end
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged it to perform that action'
      redirect_to root_path
    end
  end
  
  def logged_in?
    !!current_user
  end
end
