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
    session.delete(:user_id)
    redirect_to root_path
  end

  def omnilogin
    @user = User.find_or_create_by(email: auth[:info][:email]) do |user|
      user.first_name = auth[:info][:first_name]
      user.last_name = auth[:info][:last_name]
      user.username = auth[:info][:first_name]
      user.password = SecureRandom.hex
      # look into SecureRandom.hex later
    end
    if @user.save
      session[:user_id] = @user.id 
      redirect_to user_path(@user)
    else
      redirect_to '/'
    end
  end 

  private

  def auth
    request.env['omniauth.auth']
  end
end
