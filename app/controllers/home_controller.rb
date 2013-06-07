class HomeController < ApplicationController
  skip_before_filter :check_admin

  def index
    if session[:user_id]
      @user = User.find session[:user_id]
    end
    @active_competitions = Competition.find_all_by_active(true).reject { |competition| competition.hidden or @user.competitions.include? competition }
    @inactive_competitions = Competition.find_all_by_active(false).reject { |competition| competition.hidden or @user.competitions.include? competition }
  end
end
