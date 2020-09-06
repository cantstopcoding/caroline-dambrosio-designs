class SessionsController < ApplicationController
  def home
  end

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user) #=> "/users/#{user.id}"
    else
      flash[:message] = "Incorrect info, please try agin"
      redirect_to '/login'
    end 
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
