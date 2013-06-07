module ApplicationHelper
  def current_user
    if session[:user_id]
      user = User.find session[:user_id]
      user
    end
  end
end
