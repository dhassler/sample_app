class UsersController < ApplicationController
  
  before_filter :authenticate
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "User #{@user.email} created"
    else
      render "new"
    end
  end
  
  private
  
  def authenticate
    deny_access unless current_user && current_user.admin
  end
end
