class Admin::ProblemsController < ApplicationController
  def index
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problems = @category.problems
  end

  def show
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problem = Problem.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problem = Problem.new(:active => true)
  end

  def edit
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problem = Problem.find(params[:id])
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problem = Problem.new(params[:problem])
    @problem.categories << @category

    respond_to do |format|
      if @problem.save
        format.html { redirect_to [:admin, @competition, @category, :problems], :notice => 'Problem was successfully created.' }
        format.json { render :json => @problem, :status => :created, :location => @problem }
      else
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to [:admin, @competition, @category, :problems], :notice => 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @problem.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:category_id])
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @competition, @category, :problems] }
      format.json { head :no_content }
    end
  end
end
