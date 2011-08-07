class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if (user.admin?)
        redirect_to root_path, :notice => "Logged in as admin"
      else
        redirect_to restaurant_path(user.restaurant), :notice => "Logged in"
      end
    else
      flash.now.alert = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end

end
