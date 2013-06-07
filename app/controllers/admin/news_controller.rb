class Admin::NewsController < ApplicationController
  def index
    @competition = Competition.find(params[:competition_id])
    @news = @competition.news
  end

  def show
    @competition = Competition.find(params[:competition_id])
    @news = News.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @news = News.new
  end

  def edit
    @competition = Competition.find(params[:competition_id])
    @news = News.find(params[:id])
  end

  def create
    @news = News.new(params[:news])
    @news.competition = Competition.find params[:competition_id]


    respond_to do |format|
      if @news.save
        format.html { redirect_to admin_competition_news_index_path(@news.competition), :notice => 'News was successfully created.' }
        format.json { render :json => @news, :status => :created, :location => @news }
      else
        format.html { render :action => "new" }
        format.json { render :json => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to admin_competition_news_index_path(@news.competition), :notice => 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @news = News.find(params[:id])
    @competition = @news.competition
    @news.destroy

    respond_to do |format|
      format.html { redirect_to [:admin, @competition, @news] }
      format.json { head :no_content }
    end
  end
end
