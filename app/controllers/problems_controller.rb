class ProblemsController < ApplicationController
  skip_before_filter :check_admin
  before_filter :check_hidden
  before_filter :check_registered

  def show
    @problem = Problem.find(params[:id])
    @competition = Competition.find(params[:competition_id])
    if not @problem.categories.map{ |c| c.competition.id}.include?(@competition.id)
      redirect_to competition_url(@competition), :notice => "That problem does not exist."
    end
    @category = @problem.categories.find_by_competition_id(@competition.id)
    @user = User.find(session[:user_id])
    @solution = Solve.new(:problem_id => @problem.id, :user_id => session[:user_id])
  end
  
  def check_registered
    user = User.find_by_id session[:user_id]
    competition = Competition.find(params[:competition_id])
    if not user or not competition.users.include? user
      redirect_to root_url, :notice => "You are not registered for this competition."
    end
  end
  
  def check_hidden
    problem = Problem.find(params[:id])
    if problem.hidden
      redirect_to competition_url, :notice => "This problem isn't available yet"
    end
  end
  
end
