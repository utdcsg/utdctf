class CompetitionsController < ApplicationController
  skip_before_filter :check_admin
  before_filter :check_registered
  
  def show
    @competition = Competition.find(params[:id])
    @user = User.find(session[:user_id])
  end

  def scoreboard
    @user = User.find(session[:user_id])
    @competition = Competition.find(params[:id])
    @users = @competition.users
    @entries = @users.reject {|u| u.name == "admin"}.map {|u| {:name => u.name, :score => u.score(@competition), :ts => (u.solves.length > 0 ? u.solves.last.created_at : Time.now)} }
    @entries = @entries.sort {|x,y| [y[:score],x[:ts]] <=> [x[:score],y[:ts]]}
  end

  def stats
    @competition = Competition.find(params[:id])
    @user = User.find(session[:user_id])
  end

  protected

  def check_registered
    user = User.find_by_id session[:user_id]
    competition = Competition.find(params[:id])
    if not user or not competition.users.include? user
      redirect_to root_url, :notice => "You are not registered for this competition."
    end
  end
end
