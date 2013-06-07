class ProblemsController < ApplicationController
  skip_before_filter :check_admin

  def show
    @problem = Problem.find(params[:id])
    @competition = Competition.find(params[:competition_id])
    @category = @problem.categories.find_by_competition_id(@competition.id)
    @user = User.find(session[:user_id])
    @solution = Solve.new(:problem_id => @problem.id, :user_id => session[:user_id])
  end

end
