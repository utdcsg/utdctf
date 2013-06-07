class SolvesController < ApplicationController
  skip_before_filter :check_admin

  def create
    # Will lock if 5 attempts made in under 20 seconds
    @solve = Solve.new(params[:solve])
    @solve.user_id = session[:user_id]
    @competition = Competition.find(params[:competition_id])
    flag = params[:flag]

    if not @competition.open_to_submission
      redirect_to @competition, :notice => "#{flag == @solve.problem.flag ? "Correct!" : "Incorrect."}  However, this competition is inactive." 
    else
      if @solve.user.locked
        if Time.now - @solve.user.locked >= 60
          @solve.user.update_attribute :locked, nil
        else
          redirect_to @competition, :notice => "User is locked." 
          return
        end
      end

      if @solve.user.last_submission.nil?
        @solve.user.update_attribute :last_submission, Time.now
      else
        if Time.now - @solve.user.last_submission < 20
          @solve.user.flood_count ||= 0
          @solve.user.update_attribute :flood_count, @solve.user.flood_count + 1
        else
          @solve.user.flood_count = 1
          @solve.user.update_attribute :last_submission, Time.now
        end
      end

      if @solve.user.flood_count and @solve.user.flood_count > 5
        @solve.user.update_attribute :locked, Time.now
      end

      if @solve.user.problems and @solve.user.problems.include? @solve.problem
        redirect_to @competition, :notice => "Challenge already answered." 
      elsif flag == @solve.problem.flag
        @solve.save
        redirect_to @competition, :notice => "Correct! #{@solve.problem.points} points awarded." 
      else
        redirect_to [@competition, @solve.problem], :notice => "Wrong flag submitted."
      end
    end
  end
end
