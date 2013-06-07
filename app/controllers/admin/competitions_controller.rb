class Admin::CompetitionsController < ApplicationController
  def index
    @competitions = Competition.all
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def new
    @competition = Competition.new
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  def create
    @competition = Competition.new(params[:competition])
    @competition.hidden = true

    respond_to do |format|
      if @competition.save
        format.html { redirect_to [:admin, @competition], :notice => 'Competition was successfully created.' }
        format.json { render :json => @competition, :status => :created, :location => @competition }
      else
        format.html { render :action => "new" }
        format.json { render :json => @competition.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
   @competition = Competition.find(params[:id])

    respond_to do |format|
      if @competition.update_attributes(params[:competition])
        format.html { redirect_to [:admin, @competition], :notice => 'Competition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @competition.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @competition = Competition.find(params[:id])
    @competition.destroy

    respond_to do |format|
      format.html { redirect_to admin_competitions_path }
      format.json { head :no_content }
    end
  end

  def activate
    @competition = Competition.find(params[:id])
    @competition.update_attribute(:active,true) if @competition
    redirect_to admin_competitions_url, :notice => "Active challenge changed."
  end

  def deactivate
    @competition = Competition.find(params[:id])
    @competition.update_attribute(:active,false) if @competition
    redirect_to admin_competitions_url, :notice => "Challenge deactivated."
  end

  def hide
    @competition = Competition.find(params[:id])
    @competition.update_attribute(:hidden,true) if @competition
    redirect_to admin_competitions_url, :notice => "Competition hidden."
  end

  def unhide
    @competition = Competition.find(params[:id])
    @competition.update_attribute(:hidden,false) if @competition
    redirect_to admin_competitions_url, :notice => "Competition unhidden."
  end
end
