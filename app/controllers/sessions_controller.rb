class SessionsController < ApplicationController
  def home
  end

  def new
  end

  def create
    user = User.find_by(email: params[:user][:email])
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
