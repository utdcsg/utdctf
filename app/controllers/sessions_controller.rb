class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :check_admin

  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      person = Person.find_by_ip(request.remote_ip)
      if person.nil?
        person = Person.new(:ip => request.remote_ip)
        person.save
      end
      user.people << person unless user.people.include? person
      redirect_to root_path
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => 'Logged out'
  end
end
