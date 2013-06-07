class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :check_admin
  protect_from_forgery

  protected 

  def authorize
    unless User.find_by_id session[:user_id]
      redirect_to login_url, :notice => "Please log in"
    end
  end
  
  def check_admin
    user = User.find_by_id session[:user_id]
    if not user or user.role != 'admin'
      redirect_to root_url, :notice => "Permission denied"
    end
  end

end
