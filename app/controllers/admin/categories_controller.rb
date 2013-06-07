class Admin::CategoriesController < ApplicationController
  def index
    @competition = Competition.find(params[:competition_id])
    @categories = @competition.categories
  end

  def show
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @category = Category.new
  end

  def edit
    @competition = Competition.find(params[:competition_id])
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.competition = Competition.find params[:competition_id]


    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_competition_categories_path(@category.competition), :notice => 'Category was successfully created.' }
        format.json { render :json => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to admin_competition_categories_path(@category.competition), :notice => 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @competition = @category.competition
    @category.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @competition, @category] }
      format.json { head :no_content }
    end
  end
end
