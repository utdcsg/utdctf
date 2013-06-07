class UsersController < ApplicationController
  skip_before_filter :check_admin
  skip_before_filter :authorize

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    @user.role = :user

    respond_to do |format|
      if @user.save
        person = Person.find_by_ip(request.remote_ip)
        if person.nil?
          person = Person.new(:ip => request.remote_ip)
          person.save
        end
        @user.people << person unless @user.people.include? person
        session[:user_id] = @user.id
        format.html { redirect_to root_url, :notice => "User #{@user.name} was successfully created." }
      else
        format.html { redirect_to new_user_path, :notice => @user.errors.full_messages.join }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_url, :notice => "Profile was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def register
    @user = User.find(params[:id])
    @competition = Competition.find(params[:competition_id])
    @competition.users << @user
    redirect_to root_url, :notice => "Registered for #{@competition.name}."
  end
end
