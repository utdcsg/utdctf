class CompetitionsController < ApplicationController
  skip_before_filter :check_admin
  
  def show
    @competition = Competition.find(params[:id])
    @user = User.find(session[:user_id])
  end

  def scoreboard
    @user = User.find(session[:user_id])
    @competition = Competition.find(params[:id])
    @users = @competition.users
    @entries = @users.map {|u| {:name => u.name, :score => u.score(@competition), :ts => (u.solves.length > 0 ? u.solves.last.created_at : Time.now)} }
    @entries = @entries.sort {|x,y| [y[:score],x[:ts]] <=> [x[:score],y[:ts]]}
  end

  def stats
    @competition = Competition.find(params[:id])
    @user = User.find(session[:user_id])
  end
end
